import 'package:neat/neat_generator/class_literals_visitor.dart';
import 'package:source_gen/source_gen.dart';

class GeneratorForClassLiteralsAnnotation<T> {
  const GeneratorForClassLiteralsAnnotation({
    this.generateForFieldStartingWith,
    this.classRadical,
    this.removePrefix = false,
    this.radicalFirst = true,
    this.avoidPrefixRepetition = true,
  });

  GeneratorForClassLiteralsAnnotation.fromConstantReader(
    ConstantReader reader,
  )   : classRadical = reader.read("classRadical").literalValue as String?,
        generateForFieldStartingWith =
            reader.read("generateForFieldStartingWith").literalValue as String?,
        removePrefix = reader.read("removePrefix").literalValue as bool,
        radicalFirst = reader.read("radicalFirst").literalValue as bool,
        avoidPrefixRepetition =
            reader.read("avoidPrefixRepetition").literalValue as bool;

  final String? classRadical;
  final String? generateForFieldStartingWith;
  final bool removePrefix;
  final bool radicalFirst;
  final bool avoidPrefixRepetition;

  FieldFilter<T> filter() => FieldFilter<T>(
        startsWith: generateForFieldStartingWith,
      );

  WidgetNameExtractor extractor() => WidgetNameExtractor(
        prefix: generateForFieldStartingWith,
        classRadical: classRadical,
        removePrefix: removePrefix,
        radicalFirst: radicalFirst,
        avoidPrefixRepetition: avoidPrefixRepetition,
      );
}
