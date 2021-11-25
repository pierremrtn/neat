import 'neat_class_annotation.dart';

class GenerateSpace extends NeatClassAnnotation {
  const GenerateSpace({
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
