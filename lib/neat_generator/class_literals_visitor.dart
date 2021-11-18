import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

typedef CodeGenerator<T> = String Function(String fieldName, T value);

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

///Parse a class and generate code from literal fields
class ClassLiteralsVisitor<T> {
  const ClassLiteralsVisitor({
    required this.filter,
    required this.nameExtractor,
    required this.generator,
  });

  final FieldFilter<T> filter;
  final WidgetNameExtractor nameExtractor;
  final CodeGenerator<T> generator;

  Iterable<String> visit(
    ClassElement c,
  ) sync* {
    for (final field in c.fields) {
      final fieldName = field.displayName;

      try {
        final value =
            ConstantReader(field.computeConstantValue()).literalValue as T;
        if (filter.include(fieldName, value)) {
          final widgetName = nameExtractor.extractWidgetName(fieldName);
          yield generator(widgetName, value);
        }
      } catch (e) {}
    }
  }
}
