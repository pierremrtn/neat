class GeneratorOptions {
  const GeneratorOptions({
    this.removePluralFromWidgetName = true,
    this.avoidPrefixRepetition = true,
  });

  final bool removePluralFromWidgetName;
  final bool avoidPrefixRepetition;

  String generateWidgetName(String baseName, String fieldName) {
    if (removePluralFromWidgetName) {
      baseName = baseName.removePlural();
      fieldName = fieldName.removePlural();
    }
    return fieldName
        .addPrefix(
          baseName,
          avoidRepetition: avoidPrefixRepetition,
        )
        .capitalizeFirstChar();
  }
}

class NeatSpaces extends GeneratorOptions {
  const NeatSpaces({
    bool removePluralFromWidgetName = true,
    bool avoidPrefixRepetition = true,
  }) : super(
          removePluralFromWidgetName: removePluralFromWidgetName,
          avoidPrefixRepetition: avoidPrefixRepetition,
        );
}

extension _Format on String {
  String capitalizeFirstChar() => this[0].toUpperCase() + this.substring(1);

  String removePlural() {
    if (this.endsWith("s")) {
      return this.substring(0, this.length - 1);
    }
    return this;
  }

  String addPrefix(
    String prefix, {
    bool avoidRepetition = true,
  }) {
    if (toLowerCase().startsWith(prefix.toLowerCase())) {
      return this;
    }
    return '$prefix${this.capitalizeFirstChar()}';
  }
}
