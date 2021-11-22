import 'package:neat/neat_generator/generator_for_class_annotation.dart';

class PaddingHelpersGeneratorAnnotation
    extends GeneratorForClassLiteralsAnnotation<double> {
  const PaddingHelpersGeneratorAnnotation({
    String? classRadical = "Padding",
    String? generateForFieldStartingWith = "padding",
    bool removePrefix = false,
    bool radicalFirst = true,
    bool avoidPrefixRepetition = true,
    this.generateBinaryFlagConstructor = true,
  }) : super(
          classRadical: classRadical,
          generateForFieldStartingWith: generateForFieldStartingWith,
          removePrefix: removePrefix,
          radicalFirst: radicalFirst,
          avoidPrefixRepetition: avoidPrefixRepetition,
        );

  final bool generateBinaryFlagConstructor;
}
