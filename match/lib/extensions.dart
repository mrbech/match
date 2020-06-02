extension StringMatch on String {
  T match<T>(Map<String, T Function()> cases, {T Function() any}) {
    if (cases.containsKey(this)) {
      return cases[this]();
    }
    if (any != null) {
      return any();
    }
    throw Exception('String.match failed, found no match for: $this');
  }
}
