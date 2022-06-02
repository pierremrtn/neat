import 'package:build/build.dart';
import 'package:neat_annotations/neat_annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:neat_generator/src/padding_helpers_generator.dart';
import 'package:neat_generator/src/space_widgets_generator.dart';

class GlobalGenerator extends GeneratorForAnnotation<NeatGenerate> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
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
          buildStep,
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
          buildStep,
        ),
      );
    }

    return parts.join('\n');
  }
}
