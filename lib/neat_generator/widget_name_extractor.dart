class WidgetNameExtractor {
  const WidgetNameExtractor({
    required this.prefix,
    required this.classRadical,
    required this.removePrefix,
    required this.radicalFirst,
    required this.avoidPrefixRepetition,
  })  : assert(removePrefix == false ||
            (classRadical != null && classRadical != "")),
        assert(removePrefix == false || prefix != null);

  final String? prefix;
  final String? classRadical;
  final bool removePrefix;
  final bool radicalFirst;
  final bool avoidPrefixRepetition;

  String extractWidgetName(String fieldName) {
    String field = fieldName;
    if (removePrefix) {
      field = fieldName.replaceFirst(prefix!, "");
    }

    if (avoidPrefixRepetition &&
        (classRadical?.isNotEmpty ?? false) &&
        field.startsWithCaseInsensitive(classRadical!)) {
      field = field.substring(classRadical!.length);
    }

    if (field.isNotEmpty) {
      field = field[0].toUpperCase() + field.substring(1).toLowerCase();
    }

    final radical = classRadical ?? "";
    if (radicalFirst) {
      return "$radical$field";
    } else {
      return "$field$radical";
    }
  }
}

extension _Match on String {
  bool startsWithCaseInsensitive(String s) {
    return toLowerCase().startsWith(s.toLowerCase());
  }
}
