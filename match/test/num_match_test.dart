import 'package:match/match.dart';
import 'package:test/test.dart';

void main() {
  group('num.match', () {
    test('match eq', () {
      final x = 10;
      final result = x.match({
        eq(5): () => 1,
        eq(10): () => 2,
      });
      expect(result, 2);
    });

    test('match gt', () {
      final x = 10;
      final result = x.match({
        gt(10): () => 1,
        gt(5): () => 2,
      });
      expect(result, 2);
    });

    test('match lt', () {
      final x = 10;
      final result = x.match({
        lt(10): () => 1,
        lt(20): () => 2,
      });
      expect(result, 2);
    });

    test('match gte', () {
      final x = 10;
      final result = x.match({
        gte(10): () => 1,
        gte(5): () => 2,
      });
      expect(result, 1);
    });

    test('match lte', () {
      final x = 10;
      final result = x.match({
        lte(10): () => 1,
        lte(20): () => 2,
      });
      expect(result, 1);
    });

    test('match range', () {
      final x = 10;
      final result = x.match({
        range(1, 5): () => 1,
        range(5, 15): () => 2,
      });
      expect(result, 2);
    });

    test('match double', () {
      final x = 10.5;
      final result = x.match({
        eq(5): () => 1,
        range(10, 11): () => 2,
      });
      expect(result, 2);
    });

    test('match any', () {
      final x = 10;
      final result = x.match({
        eq(5): () => 1,
        any: () => 2,
      });
      expect(result, 2);
    });

    test('match &', () {
      final x = 10;
      final result = x.match({
        eq(10) & eq(5): () => 1,
        eq(10) & eq(10): () => 2,
      });
      expect(result, 2);
    });

    test('match |', () {
      final x = 10;
      final result = x.match({
        eq(10) | eq(5): () => 1,
        eq(10) | eq(10): () => 2,
      });
      expect(result, 1);
    });

    test('match guard (>>)', () {
      final x = 10;
      final result = x.match({
        eq(10) >> () => false: () => 1,
        eq(10) >> () => true: () => 2,
      });
      expect(result, 2);
    });

    test('match guard (>>) fall through', () {
      final x = 10;
      final result = x.match({
        eq(10) >> () => false: () => 1,
        eq(10) >> () => false: () => 2,
        any: () => 3
      });
      expect(result, 3);
    });

    test('match guard (>)', () {
      final x = 10;
      final result = x.match({
        eq(10) > false: () => 1,
        eq(10) > true: () => 2,
      });
      expect(result, 2);
    });

    test('match guard (>) fall through', () {
      final x = 10;
      final result = x.match({
        eq(10) > false: () => 1,
        eq(10) > false: () => 2,
        any: () => 3,
      });
      expect(result, 3);
    });

    test('no match', () {
      final x = 10;
      expect(() => x.match({eq(5): () => 1}), throwsException);
    });
  });
}
