import 'package:neat/neat_generator/generator_for_class_annotation.dart';

class SpaceWidgetsGeneratorAnnotation
    extends GeneratorForClassLiteralsAnnotation<double> {
  const SpaceWidgetsGeneratorAnnotation({
    String? classRadical = "Space",
    String? generateForFieldStartingWith = "space",
    bool removePrefix = false,
    bool radicalFirst = true,
    bool avoidPrefixRepetition = true,
  }) : super(
          classRadical: classRadical,
          generateForFieldStartingWith: generateForFieldStartingWith,
          removePrefix: removePrefix,
          radicalFirst: radicalFirst,
          avoidPrefixRepetition: avoidPrefixRepetition,
        );
}
