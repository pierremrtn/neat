import 'field_filter.dart';
import 'widget_name_extractor.dart';

class GeneratorForClassLiteralsAnnotation<T> {
  const GeneratorForClassLiteralsAnnotation({
    this.generateForFieldStartingWith,
    this.classRadical,
    this.removePrefix = false,
    this.radicalFirst = true,
    this.avoidPrefixRepetition = true,
  });

  final String? classRadical;
  final String? generateForFieldStartingWith;
  final bool removePrefix;
  final bool radicalFirst;
  final bool avoidPrefixRepetition;

  FieldFilter<T> filter() => FieldFilter<T>(
        startsWith: generateForFieldStartingWith,
      );

  WidgetNameExtractor extractor() => WidgetNameExtractor(
        prefix: generateForFieldStartingWith,
        classRadical: classRadical,
        removePrefix: removePrefix,
        radicalFirst: radicalFirst,
        avoidPrefixRepetition: avoidPrefixRepetition,
      );
}
