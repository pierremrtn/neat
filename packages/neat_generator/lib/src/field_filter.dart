import 'package:neat_annotations/neat_annotations.dart';

class FieldFilter<T> {
  FieldFilter(
    NeatClassAnnotation meta,
  ) : startsWith = meta.generateForFieldStartingWith;
  final String? startsWith;

  bool include(String fieldName, T value) {
    if (startsWith != null) {
      return fieldName.startsWith(startsWith!);
    }
    return true;
  }
}
