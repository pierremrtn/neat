import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:neat_annotations/neat_annotations.dart';

import 'class_literals_visitor.dart';
import 'field_filter.dart';
import 'widget_name_extractor.dart';

extension ToPaddingHelpersGeneratorAnnotation on ConstantReader {
  GeneratePadding toPaddingHelpersGeneratorAnnotation() {
    final superAnnotation = toGeneratorForClassLiteralsAnnotation();
    return GeneratePadding(
      generateForFieldStartingWith:
          superAnnotation.generateForFieldStartingWith,
      classRadical: superAnnotation.classRadical,
      removePrefix: superAnnotation.removePrefix,
      radicalFirst: superAnnotation.radicalFirst,
      avoidPrefixRepetition: superAnnotation.avoidPrefixRepetition,
      generateBinaryFlagConstructor:
          read("generateBinaryFlagConstructor").boolValue,
    );
  }
}

class PaddingHelpersGenerator extends GeneratorForAnnotation<GeneratePadding> {
  bool generateBinaryFlagConstructor = true;

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final meta = annotation.toPaddingHelpersGeneratorAnnotation();

    generateBinaryFlagConstructor = meta.generateBinaryFlagConstructor;

    final visitor = ClassLiteralsVisitor<double>(
      filter: FieldFilter(meta),
      nameExtractor: WidgetNameExtractor(meta),
      generator: generatePaddingClass,
    );

    if (generateBinaryFlagConstructor) {
      return [
        _generateBinaryFlags(),
        ...visitor.visit(element as ClassElement),
      ].join('\n');
    }
    return visitor.visit(element as ClassElement).join('\n');
  }

  String generatePaddingClass(
    String widgetName,
    double value,
  ) {
    final padding = value.toStringAsFixed(0);
    final widgetCode = Class(
      (b) => b
        ..name = widgetName
        ..extend = refer('EdgeInsets')
        ..constructors.addAll([
          if (generateBinaryFlagConstructor)
            Constructor(
              (c) => c
                ..optionalParameters.add(
                  Parameter(
                    (p) => p
                      ..name = "padding"
                      ..type = const Reference("int")
                      ..defaultTo = const Code("0"),
                  ),
                )
                ..initializers.add(
                  Code(
                    """super.only(
  left: padding & left == left ? $padding : 0,
  right: padding & right == right ? $padding : 0,
  top: padding & top == top ? $padding : 0,
  bottom: padding & bottom == bottom ? $padding : 0,)""",
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
                    ..type = const Reference("bool")
                    ..defaultTo = const Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "right"
                    ..named = true
                    ..type = const Reference("bool")
                    ..defaultTo = const Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "top"
                    ..named = true
                    ..type = const Reference("bool")
                    ..defaultTo = const Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "bottom"
                    ..named = true
                    ..type = const Reference("bool")
                    ..defaultTo = const Code("false"),
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
                    ..type = const Reference("bool")
                    ..defaultTo = const Code("false"),
                ),
                Parameter(
                  (p) => p
                    ..name = "vertical"
                    ..named = true
                    ..type = const Reference("bool")
                    ..defaultTo = const Code("false"),
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

  static String _generateBinaryFlags() => """
  const right = 0x1000;
  const left = 0x0100;
  const top = 0x0010;
  const bottom = 0x0001;
  """;
}
