import 'package:code_builder/code_builder.dart';
import 'package:neat/neat_generator/generator_for_class_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:neat/neat_generator/class_literals_visitor.dart';
import 'space_widgets_generator_annotation.dart';

extension ToSpaceWidgetsGeneratorAnnotation on ConstantReader {
  GeneratorForClassLiteralsAnnotation<double>
      toSpaceWidgetsGeneratorAnnotation() =>
          toGeneratorForClassLiteralsAnnotation<double>();
}

class SpaceWidgetsGenerator
    extends GeneratorForAnnotation<SpaceWidgetsGeneratorAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    _,
  ) {
    final meta = annotation.toSpaceWidgetsGeneratorAnnotation();

    final visitor = ClassLiteralsVisitor<double>(
      filter: meta.filter(),
      nameExtractor: meta.extractor(),
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
                    ..type = Reference("Key?"),
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
                    ..type = Reference("Key?"),
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
                    ..type = Reference("Key?"),
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
