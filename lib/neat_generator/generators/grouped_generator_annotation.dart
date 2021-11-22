import 'package:neat/neat_generator/generators/padding_helpers_generator_annotation.dart';
import 'package:neat/neat_generator/generators/space_widgets_generator_annotation.dart';

class GroupedGeneratorAnnotation {
  const GroupedGeneratorAnnotation({
    ///padding helpers generator options
    ///if null, padding helpers will not be generated
    this.padding = const PaddingHelpersGeneratorAnnotation(),

    ///space widgets generator options
    ///if null, space widgets will not be generated
    this.space = const SpaceWidgetsGeneratorAnnotation(),
  });

  final PaddingHelpersGeneratorAnnotation? padding;
  final SpaceWidgetsGeneratorAnnotation? space;
}
