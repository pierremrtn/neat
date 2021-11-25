import 'neat_class_annotation.dart';

class GeneratePadding extends NeatClassAnnotation {
  const GeneratePadding({
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
