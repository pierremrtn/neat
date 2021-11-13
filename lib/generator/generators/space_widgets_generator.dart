import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:neat/generator/generator_options.dart';
import 'class_const_field_parser.dart';

//TODO: better space generator
//
//class Space1 extends SizedBox {
//  const Space1({Key? key}) : super(height: 1, width: 1, key: key);
//  const Space1.w({Key? key}) : super(height: 0, width: 1, key: key);
//  const Space1.h({Key? key}) : super(height: 1, width: 0, key: key);
//}

class SpaceWidgetsGenerator extends GeneratorForAnnotation<NeatSpaces>
    with ClassConstFieldParser {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    __,
  ) {
    //TODO: parse config
    return parseElementAsClass(element);
  }

  @override
  String? generateForDouble(
    GeneratorOptions options,
    String field,
    double space,
  ) {
    final className = options.generateWidgetName("Space", field);
    final widgetCode = Class(
      (b) => b
        ..name = className
        ..extend = refer('StatelessWidget')
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
              ..initializers.addAll([
                Code("width = ${space.toStringAsFixed(0)}"),
                Code("height = ${space.toStringAsFixed(0)}"),
                Code("super(key: key)"),
              ])
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
              ..initializers.addAll([
                Code("width = ${space.toStringAsFixed(0)}"),
                Code("height = 0"),
                Code("super(key: key)"),
              ])
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
              ..initializers.addAll([
                Code("width = 0"),
                Code("height = ${space.toStringAsFixed(0)}"),
                Code("super(key: key)"),
              ])
              ..constant = true,
          ),
        ])
        ..fields.addAll([
          Field(
            (f) => f
              ..name = "width"
              ..modifier = FieldModifier.final$
              ..type = refer("double"),
          ),
          Field(
            (f) => f
              ..name = "height"
              ..modifier = FieldModifier.final$
              ..type = refer("double"),
          )
        ])
        ..methods.add(
          Method(
            (m) => m
              ..annotations.add(refer("override"))
              ..returns = refer('Widget')
              ..name = "build"
              ..body = const Code(
                "return SizedBox(width: width, height: height);",
              )
              ..requiredParameters.add(
                Parameter(
                  (p) => p
                    ..type = refer("BuildContext")
                    ..name = "context",
                ),
              ),
          ),
        ),
    );
    final emitter = DartEmitter();
    return '${widgetCode.accept(emitter)}';
  }
}
