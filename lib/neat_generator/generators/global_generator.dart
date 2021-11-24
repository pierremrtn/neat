import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'global_generator_annotation.dart';
import 'package:neat/neat_generator/generators/padding_helpers_generator.dart';
import 'package:neat/neat_generator/generators/space_widgets_generator.dart';

class GlobalGenerator
    extends GeneratorForAnnotation<GlobalGeneratorAnnotation> {
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
