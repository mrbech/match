typedef NumMatchCase = bool Function(num n);

extension NumMatchCaseOperators on NumMatchCase {
  NumMatchCase operator &(NumMatchCase other) {
    return (n) => this(n) && other(n);
  }

  NumMatchCase operator |(NumMatchCase other) {
    return (n) => this(n) || other(n);
  }

  NumMatchCase operator >>(bool Function() g) {
    return (n) => this(n) && g();
  }
}

NumMatchCase eq(num number) {
  return (n) => n == number;
}

NumMatchCase gt(num number) {
  return (n) => n > number;
}

NumMatchCase lt(num number) {
  return (n) => n < number;
}

NumMatchCase gte(num number) {
  return (n) => n >= number;
}

NumMatchCase lte(num number) {
  return (n) => n <= number;
}

NumMatchCase range(num from, num to) {
  return (n) => n >= from && n <= to;
}

final any = (_) => true;

extension NumMatch on num {
  T match<T>(Map<NumMatchCase, T Function()> cases, {T Function() any}) {
    final match =
        cases.entries.firstWhere((c) => c.key(this), orElse: () => null);
    if (match != null) {
      return match.value();
    }
    throw Exception('num.match failed, found no match for: $this');
  }
}
