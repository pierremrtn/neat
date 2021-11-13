import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:neat/generator/generator_options.dart';
import 'class_const_field_parser.dart';

class SpaceWidgetsGenerator extends GeneratorForAnnotation<NeatSpaces>
    with ClassConstFieldParser {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    _,
  ) {
    return parseElementAsClass(element);
  }

  @override
  String? generateForDouble(
    GeneratorOptions options,
    String field,
    double space,
  ) {
    final className = options.generateWidgetName("Space", field);
    final s = space.toStringAsFixed(0);
    final widgetCode = Class(
      (b) => b
        ..name = className
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
    return '${widgetCode.accept(emitter)}';
  }
}
