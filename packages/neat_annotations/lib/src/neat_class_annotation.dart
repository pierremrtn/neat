class NeatClassAnnotation {
  const NeatClassAnnotation({
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
}
