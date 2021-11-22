import 'package:neat/neat_generator/generators/grouped_generator_annotation.dart';
import 'package:neat/neat_generator/generators/padding_helpers_generator_annotation.dart';
import 'package:neat/neat_generator/generators/space_widgets_generator_annotation.dart';

export 'package:flutter/widgets.dart';

typedef GeneratePadding = PaddingHelpersGeneratorAnnotation;
typedef GenerateSpace = SpaceWidgetsGeneratorAnnotation;
typedef NeatGenerator = GroupedGeneratorAnnotation;

class Neat {
  static const generate = GroupedGeneratorAnnotation();
  static const generateSpace = SpaceWidgetsGeneratorAnnotation(
    generateForFieldStartingWith: null,
  );
  static const generatePadding = PaddingHelpersGeneratorAnnotation(
    generateForFieldStartingWith: null,
  );
}
