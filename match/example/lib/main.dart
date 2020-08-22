import 'package:match/match.dart';

part 'main.g.dart';

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

int eval(Expr expr) {
  return expr.match(
    value: (v) => v.value,
    add: (a) => eval(a.e1) + eval(a.e2),
  );
}

@match
enum Color {
  red,
  green,
  blue,
}

void main(List<String> arguments) {
  final e = Add(
    e1: Add(e1: Value(value: 10), e2: Value(value: 20)),
    e2: Value(value: 20),
  );
  print(eval(e));

  final r = Color.red;
  print(r.match(
    red: () => 1,
    green: () => 2,
    blue: () => 3,
  ));

  print(r.matchAny(
    red: () => 1,
    any: () => 3,
  ));
}
