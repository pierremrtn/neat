import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'field_filter.dart';
import 'widget_name_extractor.dart';

import 'generator_for_class_annotation.dart';

typedef CodeGenerator<T> = String Function(String fieldName, T value);

extension ToGeneratorForClassLiteralsAnnotation on ConstantReader {
  GeneratorForClassLiteralsAnnotation<T>
      toGeneratorForClassLiteralsAnnotation<T>() =>
          GeneratorForClassLiteralsAnnotation(
            classRadical: read("classRadical").literalValue as String?,
            generateForFieldStartingWith:
                read("generateForFieldStartingWith").literalValue as String?,
            removePrefix: read("removePrefix").literalValue as bool,
            radicalFirst: read("radicalFirst").literalValue as bool,
            avoidPrefixRepetition:
                read("avoidPrefixRepetition").literalValue as bool,
          );
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
