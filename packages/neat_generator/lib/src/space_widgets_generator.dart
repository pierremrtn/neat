import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:neat_annotations/neat_annotations.dart';

import 'class_literals_visitor.dart';
import 'field_filter.dart';
import 'widget_name_extractor.dart';

extension ToSpaceWidgetsGeneratorAnnotation on ConstantReader {
  NeatClassAnnotation toSpaceWidgetsGeneratorAnnotation() =>
      toGeneratorForClassLiteralsAnnotation();
}

class SpaceWidgetsGenerator extends GeneratorForAnnotation<GenerateSpace> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final meta = annotation.toSpaceWidgetsGeneratorAnnotation();

    final visitor = ClassLiteralsVisitor<double>(
      filter: FieldFilter(meta),
      nameExtractor: WidgetNameExtractor(meta),
      generator: generateSpaceWidget,
    );
    return visitor.visit(element as ClassElement).join('\n');
  }

  static String generateSpaceWidget(String widgetName, double space) {
    final s = space.toStringAsFixed(0);
    final widgetCode = Class(
      (b) => b
        ..name = widgetName
        ..extend = refer('SizedBox')
        ..constructors.addAll([
          Constructor(
            (c) => c
              ..optionalParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "key"
                    ..named = true
                    ..type = const Reference("Key?"),
                ),
              ])
              ..initializers.add(
                Code("super(height: $s, width: $s, key: key,)"),
              )
              ..constant = true,
          ),
          Constructor(
            (c) => c
              ..name = "w"
              ..optionalParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "key"
                    ..named = true
                    ..type = const Reference("Key?"),
                ),
              ])
              ..initializers.add(
                Code("super(height: 0, width: $s, key: key,)"),
              )
              ..constant = true,
          ),
          Constructor(
            (c) => c
              ..name = "h"
              ..optionalParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "key"
                    ..named = true
                    ..type = const Reference("Key?"),
                ),
              ])
              ..initializers.add(
                Code("super(height: $s, width: 0, key: key,)"),
              )
              ..constant = true,
          ),
        ]),
    );
    final emitter = DartEmitter();
    return widgetCode.accept(emitter).toString();
  }
}
