import 'package:neat/neat_generator/generators/padding_classes_generator.dart'
    show PaddingClassesGeneratorAnnotation;
import 'package:neat/neat_generator/generators/space_widgets_generator.dart'
    show SpaceWidgetsGeneratorAnnotation;

export 'package:flutter/widgets.dart';

typedef GeneratePaddings = PaddingClassesGeneratorAnnotation;
typedef GenerateSpaces = SpaceWidgetsGeneratorAnnotation;

class Neat {
  static const generateSpaces = SpaceWidgetsGeneratorAnnotation();
  static const generatePaddings = PaddingClassesGeneratorAnnotation();
}
