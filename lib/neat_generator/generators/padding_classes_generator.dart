import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:neat/neat_generator/class_literals_visitor.dart';
import 'package:neat/neat_generator/generator_for_class_annotation.dart';

class PaddingClassesGeneratorAnnotation
    extends GeneratorForClassLiteralsAnnotation<double> {
  const PaddingClassesGeneratorAnnotation({
    String? classRadical = "Padding",
    String? generateForFieldStartingWith,
    bool removePrefix = false,
    bool radicalFirst = true,
    bool avoidPrefixRepetition = true,
  }) : super(
          classRadical: classRadical,
          generateForFieldStartingWith: generateForFieldStartingWith,
          removePrefix: removePrefix,
          radicalFirst: radicalFirst,
          avoidPrefixRepetition: avoidPrefixRepetition,
        );

  PaddingClassesGeneratorAnnotation.fromConstantReader(
    ConstantReader reader,
  ) : super.fromConstantReader(reader);
}

class PaddingClassesGenerator
    extends GeneratorForAnnotation<PaddingClassesGeneratorAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    _,
  ) {
    final meta =
        PaddingClassesGeneratorAnnotation.fromConstantReader(annotation);

    final visitor = ClassLiteralsVisitor<double>(
      filter: meta.filter(),
      nameExtractor: meta.extractor(),
      generator: generatePaddingClass,
    );

    return [_generateHeader(), ...visitor.visit(element as ClassElement)]
        .join('\n');
  }

  static String generatePaddingClass(
    String widgetName,
    double value,
  ) {
    final padding = value.toStringAsFixed(0);
    final widgetCode = Class(
      (b) => b
        ..name = widgetName
        ..extend = refer('EdgeInsets')
        ..constructors.addAll([
          Constructor(
            (c) => c
              ..optionalParameters.add(
                Parameter(
                  (p) => p
                    ..name = "padding"
                    ..type = Reference("int")
                    ..defaultTo = Code("0"),
                ),
              )
              ..initializers.add(
                Code(
                  """super.only(
  left: padding & top == 1 ? $padding : 0,
  right: padding & right == 1 ? $padding : 0,
  top: padding & top == 1 ? $padding : 0,
  bottom: padding & bottom == 1 ? $padding : 0,)""",
                ),
              )
              ..constant = true,
          ),
          Constructor(
            (c) => c
              ..name = "all"
              ..initializers.add(
                Code("super.all($padding)"),
              )
              ..constant = true,
          ),
          Constructor(
            (c) => c
              ..name = "only"
              ..optionalParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "left"
                    ..named = true
                    ..type = Reference("bool")
                    ..defaultTo = Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "right"
                    ..named = true
                    ..type = Reference("bool")
                    ..defaultTo = Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "top"
                    ..named = true
                    ..type = Reference("bool")
                    ..defaultTo = Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "bottom"
                    ..named = true
                    ..type = Reference("bool")
                    ..defaultTo = Code("false"),
                ),
              ])
              ..initializers.add(
                Code(
                  """super.only(
  left: left ? $padding : 0,
  right: right ? $padding : 0,
  top: top ? $padding : 0,
  bottom: bottom ? $padding : 0,
)""",
                ),
              )
              ..constant = true,
          ),
          Constructor(
            (c) => c
              ..name = "horizontal"
              ..initializers.add(
                Code("super.symmetric(horizontal: $padding, vertical: 0)"),
              )
              ..constant = true,
          ),
          Constructor(
            (c) => c
              ..name = "vertical"
              ..initializers.add(
                Code("super.symmetric(vertical: $padding, horizontal: 0)"),
              )
              ..constant = true,
          ),
          Constructor(
            (c) => c
              ..name = "symmetric"
              ..optionalParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = "horizontal"
                    ..named = true
                    ..type = Reference("bool")
                    ..defaultTo = Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "vertical"
                    ..named = true
                    ..type = Reference("bool")
                    ..defaultTo = Code("false"),
                ),
              ])
              ..initializers.add(
                Code("""super.symmetric(
                      horizontal: horizontal ? $padding : 0,
                      vertical: vertical ? $padding : 0)"""),
              )
              ..constant = true,
          ),
        ]),
    );
    final emitter = DartEmitter();
    return widgetCode.accept(emitter).toString();
  }

  static String _generateHeader() => """
  const right = 0x1000;
  const left = 0x0100;
  const top = 0x0010;
  const bottom = 0x0001;
  """;
}
