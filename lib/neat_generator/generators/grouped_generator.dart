import 'package:build/build.dart';
import 'package:neat/neat_generator/generators/padding_classes_generator.dart';
import 'package:neat/neat_generator/generators/space_widgets_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

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

class GroupedGenerator
    extends GeneratorForAnnotation<GroupedGeneratorAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep step,
  ) {
    final List<String> parts = [];

    //padding
    final paddingAnnotation = annotation.read("padding");
    if (!paddingAnnotation.isNull) {
      final paddingGen = PaddingHelpersGenerator();
      parts.add(
        paddingGen.generateForAnnotatedElement(
          element,
          paddingAnnotation,
          step,
        ),
      );
    }

    //space
    final spaceAnnotation = annotation.read("space");
    if (!spaceAnnotation.isNull) {
      final spaceGen = SpaceWidgetsGenerator();
      parts.add(
        spaceGen.generateForAnnotatedElement(
          element,
          spaceAnnotation,
          step,
        ),
      );
    }

    return parts.join('\n');
  }
}
