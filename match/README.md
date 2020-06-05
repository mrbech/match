# match
`match` extension methods for Dart. Inspired by pattern matching from functional
programming languages and Kotlin's `when` expression.

This library contains `@match` annotation for generating custom `match` extensions
and extension methods for dart builtin types.

## Class match

Similar to `sealed` classes in Kotlin (discriminated unions) a match
extension method for a single level class hierarchy can be generated using the
`@match` annotation. All classes must be defined in the same file.

```dart
//types.dart:
import 'package:match/match.dart';

part 'types.g.dart';

@match
abstract class Expr {}

class Value implements Expr {
  int value;
  Value({this.value});
}

class Add implements Expr {
  Expr e1;
  Expr e2;
  Add({this.e1, this.e2});
}
```

A match extension method on `Expr` function will be generated in the
`types.g.dart` file. And can be used as follows:

```dart
int eval(Expr expr) {
  return expr.match(
    value: (v) => v.value,
    add: (a) => eval(a.e1) + eval(a.e2),
    any: () => 0,
  );
}

final e = Add(
  e1: Add(e1: Value(value: 10), e2: Value(value: 20)),
  e2: Value(value: 20),
);

expect(eval(e), 50);
```

The method takes an optional named function argument per subclass and an `any`
named argument that will called if none of the provided arguments matches. If
`any` is not provided and no argument matches an exception will be thrown at
runtime.

## Enum match

An `enum` can also be annotated with `@match` to generate a `match` extension
method:

```dart
//types.dart:
import 'package:match/match.dart';

part 'types.g.dart';

@match
enum Color {
  red,
  green,
  blue,
}

final r = Color.red;
final result = r.match(
  red: () => 1,
  green: () => 2,
  any: () => 3,
);
expect(result, 1);
```

## Dart builtin types match
For Dart builtin types the `match` extension methods works a bit differently.
Here we have a DSL for match cases that allows for advanced value matching. Lets
look on an example where we match an integer:

```dart
import 'package:match/match.dart';

final x = 10;
final y = true;
final result = x.match({
  gt(100): () => 1,
  eq(10) | eq(20): () => 2,
  range(30, 40): () => 3,
  any: () => 3,
});

expect(result, 2);
```

Each case is expressed using a tiny DSL that allows for building more complex matching. The
DSL consists of functions that matches the value of `x` and operators that
combines the functions for more complicated matching. If a case matches the
values of `x` the corresponding function is run and the result returned. If no
cases matches an exception will be thrown at runtime.

We have the following general combining operators for the DSL:

- `e1 | e2` the "or" operator matches x if either `e1` or `e2` matches `x`.
- `e1 & e2` the "and" operator matches x if both `e1` and `e2` matches `x`.

Additionally we have the "guard" operators `>` and `>>`:

```dart
import 'package:match/match.dart';

final x = 10;
final y = true;
final result = x.match({
  eq(10) > !y : () => 1,
  eq(10) > y : () => 2,
  eq(10) >> () => !y : () => 3,
  eq(10) >> () => y : () => 4,
});

expect(result, 2);
```

- `e1 > bool` where the right hand side of `>` is a boolean expression that needs to
return true for `x` to match the case.
- `e1 >> bool Function()` where the right hand side of `>>` is a boolean
function that needs to return true for the `x` to match the case.


### String.match

```dart
import 'package:match/match.dart';

final s = 'aaa';
final result = s.match({
  eq('aaa') | eq('ccc'): () => 1,
  eq('bbb'): () => 2,
  any: () => 3,
});

expect(result, 1);
```

Supported match functions:

- `eq(s)` matches if `x == s`
- `any` matches any values of `x`

### num.match (double/int)

```dart
import 'package:match/match.dart';

final x = 10;
final result = x.match({
  gt(100): () => 1,
  eq(10) | eq(20): () => 2,
  range(30, 40): () => 3,
  any: () => 3,
});

expect(result, 2);
```

Supported match functions:

- `eq(n)` matches if `x == n`
- `lt(n)` matches if `x < n`
- `gt(n)` matches if `x > n`
- `lte(n)` matches if `x <= n`
- `gte(n)` matches if `x >= n`
- `range(from, to)` matches if `x >= from && x <= to`
- `any` matches any values of `x`

## Setup

Add the following to your pubspec.yaml:

```yaml
dependencies:
  match: ^0.1.0
dev_dependencies:
  build_runner:
  match_generator: ^0.1.0
```

If you are using the `@match` annotation run:

> pub run build_runner build
