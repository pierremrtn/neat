# Neat.

Neat is a collection of small opinionated utilities designed to helps writing short and clean flutter code.

## BuildContext extensions

Neat provides a set of `BuildContext` extension designed to reduces the amount of boilerplate code needed to achieve basic tasks in Flutter.

### Text helpers

A collection of methods to create Text widgets with pre-filled corresponding style from the context's textTheme.

**before**
```dart
Text(
  "Clean code is simple and direct.",
  style: Theme.of(context).textTheme.titleMedium,
);
```
**after**
```dart
context.titleMedium("Clean code is simple and direct.");
```

Theses helpers give you access to every `Text` properties so you can use them -like regular text widgets.
```dart
context.titleMedium(
  String text, {
  Key? key,
  TextStyle? style,
  StrutStyle? strutStyle,
  TextAlign? textAlign,
  TextDirection? textDirection,
  Locale? locale,
  bool? softWrap,
  TextOverflow? overflow,
  double? textScaleFactor,
  int? maxLines,
  String? semanticsLabel,
  TextWidthBasis? textWidthBasis,
  TextHeightBehavior? textHeightBehavior,
});
```

In addition, Neat provides a text helper method for each text theme style:
```dart
```

### Texts theme override
Neat also provide an simple way to override the base text theme's `TextStyle`.
Any `TextStyle` object passed through the style property of a text helper will be automatically merged with the corresponding text theme's base style thanks to `TextStyle.merge` method.

**before**
```dart
Text(
  "Clean code reads like well-written prose.",
  style: Theme.of(context).textTheme.titleMedium?.copyWith(
    color: Colors.blue,
  ),
);
```

**after**
```dart
context.titleMedium(
  "Clean code reads like well-written prose.",
  style: TextStyle(color: Colors.blue),
);
```

### Theme access

A collection of helpers to facilitate the theme access.

**before**
```dart
Theme.of(context);
Theme.of(context).textTheme;
Theme.of(context).colorScheme;
```

**after**
```dart
context.theme;
context.textTheme;
context.colorScheme;
```