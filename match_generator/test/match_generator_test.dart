import 'package:match/match.dart';
import 'package:test/test.dart';

part 'match_generator_test.g.dart';

@match
abstract class Expr {}

class Value implements Expr {
  int value;
  Value({required this.value});
}

class Add implements Expr {
  Expr e1;
  Expr e2;
  Add({required this.e1, required this.e2});
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

void main() {
  group('match generator for classes', () {
    test('eval Expr', () {
      final e = Add(
        e1: Add(e1: Value(value: 10), e2: Value(value: 20)),
        e2: Value(value: 20),
      );

      expect(eval(e), 50);
    });

    test('matchAny', () {
      final e = Value(value: 10);
      final result = e.matchAny(
        add: (a) => 1,
        any: () => 2,
      );
      expect(result, 2);
    });
  });

  group('match generator for enums', () {
    test('match red', () {
      final c = Color.red;
      final result = c.match(
        red: () => 1,
        green: () => 2,
        blue: () => 3,
      );
      expect(result, 1);
    });

    test('match green', () {
      final c = Color.green;
      final result = c.match(
        red: () => 1,
        green: () => 2,
        blue: () => 3,
      );
      expect(result, 2);
    });

    test('match blue', () {
      final c = Color.blue;
      final result = c.match(
        red: () => 1,
        green: () => 2,
        blue: () => 3,
      );
      expect(result, 3);
    });

    test('matchAny', () {
      final c = Color.blue;
      final result = c.matchAny(
        red: () => 1,
        any: () => 2,
      );
      expect(result, 2);
    });
  });
}
