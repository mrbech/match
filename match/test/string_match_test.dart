import 'package:match/match.dart';
import 'package:test/test.dart';

void main() {
  group('String.match', () {
    test('readme example', () {
      final s = 'aaa';
      final result = s.match({
        eq('aaa') | eq('ccc'): () => 1,
        eq('bbb'): () => 2,
        any: () => 3,
      });

      expect(result, 1);
    });

    test('Match test', () {
      final s = 'test';
      final result = s.match({
        eq('wrong'): () => 1,
        eq('test'): () => 2,
      });
      expect(result, 2);
    });

    test('any', () {
      final s = 'aaa';
      final result = s.match(
        {
          eq('wrong'): () => 1,
          eq('test'): () => 2,
          any: () => 3,
        },
      );
      expect(result, 3);
    });

    test('no match', () {
      final s = 'aaa';
      expect(
          () => s.match(
                {
                  eq('wrong'): () => 1,
                  eq('test'): () => 2,
                },
              ),
          throwsException);
    });
  });
}
