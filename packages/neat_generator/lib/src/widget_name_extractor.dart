import 'package:neat_annotations/neat_annotations.dart';

class WidgetNameExtractor {
  WidgetNameExtractor(
    NeatClassAnnotation meta,
  )   : prefix = meta.generateForFieldStartingWith,
        classRadical = meta.classRadical,
        removePrefix = meta.removePrefix,
        radicalFirst = meta.radicalFirst,
        avoidPrefixRepetition = meta.avoidPrefixRepetition,
        assert(meta.removePrefix == false ||
            (meta.classRadical != null && meta.classRadical != "")),
        assert(meta.removePrefix == false ||
            meta.generateForFieldStartingWith != null);

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
      field = field[0].toUpperCase() + field.substring(1);
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
