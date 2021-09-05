import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';

class Utils {
  static capitalizeFirstChar(String s) => s[0].toUpperCase() + s.substring(1);

  static varNameToClassBaseFormat(String varName) {
    var base = capitalizeFirstChar(varName);
    if (base.endsWith("s")) {
      base = base.substring(0, base.length - 1);
    }
    return base;
  }

  static List<double> tryConvertToListDouble(VariableElement element) {
    if (!element.type.isDartCoreList) {
      throw ("invalid element type");
    }
    return element
        .computeConstantValue()!
        .toListValue()!
        .map((DartObject v) => v.toDoubleValue()!)
        .toList();
  }

  static Map<String, double> tryConvertToMapStringDouble(
    VariableElement element,
  ) {
    if (!element.type.isDartCoreMap) {
      throw ("invalid element type");
    }
    return Map.fromEntries(
      element.computeConstantValue()!.toMapValue()!.entries.map(
            (MapEntry<DartObject?, DartObject?> e) => MapEntry<String, double>(
              e.key!.toStringValue()!,
              e.value!.toDoubleValue()!,
            ),
          ),
    );
  }
}
