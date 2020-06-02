extension StringCamelCase on String {
  String toCamelCase() {
    return this[0].toLowerCase() + substring(1);
  }
}
