import 'package:neat/neat_generator/generators/grouped_generator.dart';
import 'package:neat/neat_generator/generators/padding_classes_generator.dart'
    show PaddingClassesGeneratorAnnotation;
import 'package:neat/neat_generator/generators/space_widgets_generator.dart'
    show SpaceWidgetsGeneratorAnnotation;

export 'package:flutter/widgets.dart';

typedef GeneratePadding = PaddingClassesGeneratorAnnotation;
typedef GenerateSpace = SpaceWidgetsGeneratorAnnotation;
typedef NeatGenerator = GroupedGeneratorAnnotation;

class Neat {
  static const generate = GroupedGeneratorAnnotation();
  static const generateSpace = SpaceWidgetsGeneratorAnnotation(
    generateForFieldStartingWith: null,
  );
  static const generatePadding = PaddingClassesGeneratorAnnotation(
    generateForFieldStartingWith: null,
  );
}
