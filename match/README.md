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
//result: 1
```

## String.match

```dart
import 'package:match/match.dart';

final s = 'aaa';
final result = s.match(
  {
    'aaa': () => 1,
    'bbb': () => 2,
  },
  any: () => 3,
);
//result: 1
```

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
