# Neat.

Neat is a collection of small opinionated utilities designed to helps writing short and clean Flutter code.

# Summary

* <a href="buildcontext-extensions">BuildContext extensions</a>
  * <a href="text-helpers">Text helpers</a>
  * <a href="theme-accessors">Theme accessors</a>
* <a href="generated-widgets-and-helpers">Generated widget and helpers</a>
  * <a href="setup-the-generator">Setup the generator</a>
  * <a href="space-widgets">Space widgets</a>
  * <a href="padding-helpers">Padding helpers</a>

## BuildContext extensions

Neat provides a set of `BuildContext` extensions designed to reduce the amount of boilerplate code needed to achieve basic tasks in Flutter.

### Text helpers

A collection of methods to create Text widgets with pre-filled corresponding style from the context's `textTheme`.

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

Theses helpers give you access to every `Text` properties so you can use them like regular text widgets.
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

Neat provides a text helper method for each text theme style:
```dart
// Material 3
context.displayLarge('displayLarge');
context.displayMedium('displayMedium');
context.displaySmall('displaySmall');
context.headlineLarge('headlineLarge');
context.headlineMedium('headlineMedium');
context.headlineSmall('headlineSmall');
context.titleLarge('titleLarge');
context.titleMedium('titleMedium');
context.titleSmall('titleSmall');
context.bodyLarge('bodyLarge');
context.bodyMedium('bodyMedium');
context.bodySmall('bodySmall');
context.labelLarge('labelLarge');
context.labelMedium('labelMedium');
context.labelSmall('labelSmall');

// Material 2
context.headline1('headline1');
context.headline2('headline2');
context.headline3('headline3');
context.headline4('headline4');
context.headline5('headline5');
context.headline6('headline6');
context.subtitle1('subtitle1');
context.subtitle2('subtitle2');
context.bodyText1('bodyText1');
context.bodyText2('bodyText2');
context.caption('caption');
context.buttonText('button');
context.overline('overline');
```

### Text's theme override
Neat also provides a simple way to override the base text theme's `TextStyle`.
Any `TextStyle` object passed through the style property of a text helper will be automatically merged with the corresponding text theme's base style using `TextStyle.merge` method.

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

### Theme accessors

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

## Generated widgets and helpers

A collection of code generators designed to generate project-specific convenience widgets and helpers.

> 🚨 Make sure you have correctly installed neat_generator and build_runner as dev dependencies to use this part of the package.

> 🔧 This part of the package is optional. If you don't like it, just don't install neat_generator.

### Setup the generator

If you want to use the Neat's code generator, you will need neat_generator package and and a typical build_runner/code-generator setup. Run the following command to add neat_generator and build_runner packages to your dev dependencies:

```bash
flutter pub add neat_generator --dev
flutter pub add build_runner --dev
```
These commands will add the following dependencies to your pubspec.yaml file:

```yaml
dependencies:
  neat:

dev_dependencies:
  neat_generator:
  build_runner:
```

To run neat's generator, use the following command. You can find more infos on [build_runner's pub page](https://pub.dev/packages/build_runner).
```dart
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Ignore lint warnings on generated files
Depending on your lint options, Neat Generator may cause your linter to report warnings.

The solution to this problem is to tell the linter to ignore generated files, by modifying your analysis_options.yaml:
```
analyzer:
  exclude:
    - "**/*.nt.dart"
```

## Dimensions class based generated widgets

A good practice is to keep all constants inside a dedicated data class so all your widget can share same values:
```dart
class Dimensions {
  // Blank Spaces
  static const double spaceSmall = 8;
  static const double spaceMedium = 13;
  static const double spaceLarge = 21;

  // Paddings
  static const double paddingSmall = 3;
  static const double paddingMedium = 5;
  static const double paddingLarge = 8;
}
```
Then you can access theses values inside your widget tree:
```dart
SizedBox(
  width: Dimensions.spaceSmall
  height: Dimensions.spaceSmall
);
Container(
  padding: EdgeInsets.all(Dimensions.paddingSmall),
  child: ...
)
```
Neat provides a set of generators that can parse such data classes and generate useful widgets with pre-filled values. To use a generator,
annotate your data class with `@Neat.generate` and run the `flutter pub run build_runner build`.

_dimensions.dart_
```dart
import 'package:neat/generator.dart';

part 'dimensions.nt.dart';

@Neat.generate
class Dimensions {
  static const double spaceSmall = 21;
  static const double spaceMedium = 34;
  static const double spaceLarge = 55;
}
```

### Space widgets
Generate a set of `SizedBox` with pre-filled width and height, based on the data class you've provided.

By default, the space widget generator will use generate a `Space` widget for each constant of the class starting with `space`. You can customize this behavior by using the `@NeatGenerate()` annotation. See [generator options](https://github.com/Pierre2tm/neat/blob/main/packages/neat/doc/generator.md) for advanced usage.

**before**
```dart
SizedBox(height: Dimensions.spaceSmall, width: Dimensions.spaceSmall);
SizedBox(height: 0, width: Dimensions.spaceMedium);
SizedBox(height: Dimensions.spaceLarge, width: 0);
```

**after**
```dart
const SpaceSmall();   
const SpaceMedium.w();
const SpaceLarge.h();
```

## Padding helpers
Generate a set of classes that inherit from `EdgeInsets` with pre-filled padding values, based on the data class you've provided.

By default, the space widget generator will use generate a `Padding` widget for each constant of the class starting with `padding`. You can customize this behavior by using the `@NeatGenerate()` annotation. See [generator options](https://github.com/Pierre2tm/neat/blob/main/packages/neat/doc/generator.md) for advanced usage.

**before**
```dart
EdgeInsets.all(Dimensions.paddingSmall),

EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
EdgeInsets.symmetric(vertical: Dimensions.paddingMedium),

EdgeInsets.only(right: Dimensions.paddingLarge),

EdgeInsets.only(
  right: Dimensions.paddingLarge,
  left: Dimensions.paddingLarge,
  bottom: Dimensions.paddingLarge,
),
```

**after**
```dart
PaddingSmall(),

PaddingMedium.horizontal(),
PaddingMedium.vertical(),

PaddingLarge.right(),

// only available if generateBinaryFlagConstructor is true
PaddingLarge(right | left | bottom),
```