typedef MatchCase<T> = bool Function(T n);

/// Internal generic match that works on any type.
/// Considering if this should be public, currently clashes with generated match extensions.
extension _GenericMatch<X> on X {
  T gmatch<T>(Map<MatchCase<X>, T Function()> cases) {
    final match =
        cases.entries.firstWhere((c) => c.key(this), orElse: () => null);
    if (match != null) {
      return match.value();
    }
    throw Exception('${X}.match failed, found no match for: $this');
  }
}

extension StringMatch on String {
  T match<T>(Map<MatchCase<String>, T Function()> cases) {
    return gmatch(cases);
  }
}

extension IntMatch on int {
  T match<T>(Map<MatchCase<int>, T Function()> cases) {
    return gmatch(cases);
  }
}

extension DoubleMatch on double {
  T match<T>(Map<MatchCase<double>, T Function()> cases) {
    return gmatch(cases);
  }
}

extension MatchCaseOperators<T> on MatchCase<T> {
  MatchCase<T> operator &(MatchCase<T> other) {
    return (n) => this(n) && other(n);
  }

  MatchCase<T> operator |(MatchCase<T> other) {
    return (n) => this(n) || other(n);
  }

  MatchCase<T> operator >>(bool Function() g) {
    return (n) => this(n) && g();
  }

  MatchCase<T> operator >(bool g) {
    return (n) => this(n) && g;
  }
}

MatchCase<T> eq<T>(T value) {
  return (n) => n == value;
}

final any = (dynamic _) => true;

MatchCase<num> gt(num number) {
  return (n) => n > number;
}

MatchCase<num> lt(num number) {
  return (n) => n < number;
}

MatchCase<num> gte(num number) {
  return (n) => n >= number;
}

MatchCase<num> lte(num number) {
  return (n) => n <= number;
}

MatchCase<num> range(num from, num to) {
  return (n) => n >= from && n <= to;
}
