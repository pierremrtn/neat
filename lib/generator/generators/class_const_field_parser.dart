import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:neat/generator/generator_options.dart';

class ClassConstFieldParser {
  String parseElementAsClass(
    Element e, {
    GeneratorOptions options = const GeneratorOptions(),
  }) {
    if (e is ClassElement) {
      return _generateCodeForEachField(options, e).join('\n');
    }
    throw "${e.displayName} is not a class";
  }

  Iterable<String?> _generateCodeForEachField(
    GeneratorOptions options,
    ClassElement e,
  ) sync* {
    for (final field in e.fields) {
      final fieldName = field.displayName;
      if (field.isConst) {
        //TODO: enable annotation overriding
        final c = ConstantReader(field.computeConstantValue());
        if (c.isNull) throw "$fieldName should not be null";

        if (c.isBool)
          yield generateForBool(
            options,
            fieldName,
            c.boolValue,
          );

        if (c.isInt)
          yield generateForInt(
            options,
            fieldName,
            c.intValue,
          );

        if (c.isDouble)
          yield generateForDouble(
            options,
            fieldName,
            c.doubleValue,
          );

        if (c.isString)
          yield generateForString(
            options,
            fieldName,
            c.stringValue,
          );
      } else {
        throw "$fieldName should be const";
      }
    }
  }

  String? generateForBool(
    GeneratorOptions option,
    String field,
    bool value,
  ) =>
      null;
  String? generateForInt(
    GeneratorOptions option,
    String field,
    int value,
  ) =>
      null;
  String? generateForDouble(
    GeneratorOptions option,
    String field,
    double value,
  ) =>
      null;
  String? generateForString(
    GeneratorOptions option,
    String field,
    String value,
  ) =>
      null;
}
