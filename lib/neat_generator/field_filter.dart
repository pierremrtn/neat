class FieldFilter<T> {
  const FieldFilter({
    this.startsWith,
  });
  final String? startsWith;

  bool include(String fieldName, T value) {
    if (startsWith != null) {
      return fieldName.startsWith(startsWith!);
    }
    return true;
  }
}
