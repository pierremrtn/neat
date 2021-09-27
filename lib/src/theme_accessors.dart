import 'package:flutter/material.dart';

extension NeatThemeAccessor on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
}
