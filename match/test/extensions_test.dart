import 'package:match/match.dart';
import 'package:test/test.dart';

void main() {
  group('String.match', () {
    test('Match test', () {
      final s = 'test';
      final result = s.match({
        'wrong': () => 1,
        'test': () => 2,
      });
      expect(result, 2);
    });

    test('any', () {
      final s = 'aaa';
      final result = s.match(
        {
          'wrong': () => 1,
          'test': () => 2,
        },
        any: () => 3,
      );
      expect(result, 3);
    });

    test('no match', () {
      final s = 'aaa';
      expect(
          () => s.match(
                {
                  'wrong': () => 1,
                  'test': () => 2,
                },
              ),
          throwsException);
    });
  });
}
