# Neat 

[![pub package](https://img.shields.io/pub/v/neat.svg?label=neat&color=blue)](https://pub.dev/packages/neat)
[![pub package](https://img.shields.io/pub/v/neat_generator.svg?label=neat_generator&color=blue)](https://pub.dev/packages/neat_generator)

Welcome to Neat, a utility package that helps make clean Flutter code.

Flutter framework is very verbose and widget trees quickly becomes difficult to read. Neat package is designed to make the code more expressive, shorter and easier to understand by introducing convenient solutions for common patterns without requiring any additional work from your part.

Actually, neat provide 4 types of helpers and widgets:
- **Text helpers** that helps you create headlines/subtitles/bodyTexts
- **Theme accessors** for easily access theme's data
- **Space widgets**, a blank space widgets, generated from your own data that inherit from SizedBox
- **Padding helpers**, for easily creating padding thanks to helpers generated from your own data

Take this example, without neat:
```dart
import 'dimensions.dart'; //you declare constants in this file

Text(
  "Flutter is awesome...",
  style: Theme.of(context).textTheme.headline1,
),
const SizedBox(
  height: Dimensions.spaceSmall,
),
Container(
  color: Theme.of(context).colorScheme.surface,
  padding: EdgeInsets.only(
    left: Dimensions.paddingSmall,
    right: Dimensions.paddingSmall,
    bottom: Dimensions.paddingSmall,
  ),
  child: Text(
    "...but its a little bit verbose",
    style: Theme.of(context).textTheme.bodyText1?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    ),
  ),
),
```

With Neat you could write:
```dart
import 'package:neat/neat.dart';
import 'dimensions.dart';

context.headline1("Neat make your life easier"),
const SpaceSmall(),
Container(
  color: context.colorScheme.surface,
  padding: PaddingSmall(left | right | bottom),
  child: context.bodyText1(
    "you can override the style",
    style: TextStyle(color: context.colorScheme.primary),
  ),
),
```
**_Pretty neat, isn't it ?_**

# Summary
* <a href="#install">Installation</a>
* <a href="#features">Features</a>
* <a href="#text-helpers">Text helpers</a>
* <a href="#theme-accessors">Theme accessors</a>
* <a href="#neat-generator">Neat generator</a>
  * <a href="#basic-usage">Basic usage</a>
  * <a href="#ignore-lint-warnings-on-generated-files">Ignore lint warnings on generated files</a>
  * <a href="#space-widgets">Space widgets</a>
    * <a href="#generated-constructors">Generated constructors</a>
    * <a href="#example">Example</a>
  * <a href="#padding-helpers">Padding helpers</a>
    * <a href="#-generated-constructors-1">Generated Constructors</a>
    * <a href="#example-1">Example</a>
* <a href="#contributions">Contributions</a>


# How to use
## Installing
Install Neat by running following command:
```
flutter pub add neat
```
If you want to use the Neat's code generator, you will need neat_generator package and and a typical build_runner/code-generator setup. Run the following command to add neat_generator and build_runner packages to your dev dependencies:
```
flutter pub add neat_generator --dev
flutter pub add build_runner --dev
```
These commands will add the following dependencies to your `pubspec.yaml` file:
```yaml
# pubspec.yaml
dependencies:
  neat:

dev_dependencies:
  neat_generator:
  build_runner:
```

# Features
Neat has two distinct parts:
* `neat` package, a collection of helpers and widgets that you can import with `import 'package:neat/neat.dart';`.

* `neat_generator` package, a code generator that you should install as a dev dependency and run using `build_runner` package.

## Text helpers
In most flutter applications, you define TextStyles in your material `ThemeData` and then to create, for example, a Headline1, you should do the following:
```dart
Text(
    "Headline1",
    style: Theme.of(context).textTheme.headline1,
),
```
If you want to override some properties of the style it getting even worth:
```dart
Text(
  "Headline1",
  style: Theme.of(context)
      .textTheme
      .headline1
      ?.copyWith(color: Colors.red),
),
```
Neat introduce a collection of extension on `BuildContext` that simplify the creation of headlines and other types of text defined in material textTheme:
```dart
import 'package:neat/neat.dart';

// It's that simple !
context.headline1("Headline1")

// You can override the style
context.headline1(
    "Headline1",
    style: TextStyle(color: Colors.gold),
),
```

Every text types are available:
```dart
context.headline1("Headline1"),
context.headline2("Headline2"),
context.headline3("Headline3"),
context.headline4("Headline4"),
context.headline5("Headline5"),
context.headline6("Headline6"),
context.subtitle("Subtitle"),
context.bodyText("BodyText"),
context.caption("caption"),
context.overline("overline"),
//textTheme.button has been renamed to avoid confusions
context.buttonText("button"),
```

If you specify a `TextStyle`, it will be merged with corresponding base theme found in your `textTheme`, like this:
```dart
Theme.of(context).textTheme.{textType}?.merge(style),
```

All text extensions have the same properties as the regular `Text` widget:
```dart
context.headline1(
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
    FontWeight? weight,
  }),
```

## Theme accessors
Without Neat, you access ThemeData, textTheme and colorScheme in the following way:
```dart
Theme.of(context);
Theme.of(context).textTheme;
Theme.of(context).colorScheme;
```
Neat introduce an alternative way to access your theme:
```dart
import 'package:neat/neat.dart';

context.theme;
context.textTheme;
context.colorScheme;
```

## Neat Generator
When you want to keep your spacing and padding consistent across your app, you often end up with a Dimension class holding all your variables at the same place, like this:
```dart
class Dimensions {
    static const double paddingSmall = 8;
    static const double paddingMedium = 13;
    static const double paddingBig = 21;

    static const double spaceSmall = 13;
    static const double spaceMedium = 21;
    static const double spaceBig = 34;
}
```
Then you use these values in your app:
```dart
const SizedBox(height: Dimensions.spaceSmall),
Padding(
    padding: const EdgeInsets.only(
      top: Dimensions.paddingMedium, 
      left: Dimensions.paddingMedium,
    ),
    child: ...,
),
```
Neat helps you push it further by generating specialized helpers and widgets based on your data class, without wasting time coding it yourself:
```dart
//Generated Space widget, inherit from SizedBox class,
const SpaceSmall(),

Padding(
  //Generated Padding helper, inherit form EdgeInsets class
  padding: PaddingMedium(top | left),
  child: ...,
)
```
The generator is flexible and let you use multiple data source class, configure how widget names are generated, filters what field to include or exclude from generation, etc. See <a href="https://github.com/Pierre2tm/neat/blob/main/packages/neat/doc/generator.md">generator options</a> for advanced usage. 

### Basic usage
Create a `Dimensions` class and annotate it with `@Neat.generate`. Neat generator will generate one `Space` widget for each field that starts with "space" and one padding helper for each field that starts with "padding".

You're not obligated to use only one data class, there are annotations to generate space widget and padding separately. You can also change field prefix and generated class base name if you need to. More details about advanced configuration <a href="https://github.com/Pierre2tm/neat/blob/main/packages/neat/doc/generator.md#global-generator">here</a>.

*dimensions.dart*
```dart
//import generator's annotations
import 'package:neat/generator.dart';

part 'dimensions.nt.dart';

@Neat.generate
class Dimensions {
  static const double spaceSmall = 21;
  static const double spaceMedium = 34;
  static const double spaceBig = 55;
  static const double spaceAnyNameYouWant = 42;

  static const double paddingSmall = 21;
  static const double paddingMedium = 34;
  static const double paddingBig = 55;
  static const double paddingAnyNumberYouWant = 42;
}
```
Note that like most code-generators, Neat will need you to both import the annotation (meta) and use the part keyword on the top of your files.

As such, a file that wants to use Neat's code generator will start with:

```dart
import 'package:neat/generator.dart';

part 'my_file.nt.dart';
```

Make sure you have installed the build_runner package, then run the generator with the command `flutter pub run build_runner build`.
I recommend using the option `--delete-conflicting-outputs` to avoid problems during builds.

Based on your class, Neat will generate the following helpers/widgets:
```dart
SpaceSmall              // 21
SpaceMedium             // 34
SpaceBig                // 55
SpaceAnyNameYouWant     // 42

PaddingSmall            // 21
PaddingMedium           // 34
PaddingBig              // 55
PaddingAnyNumberYouWant // 42
``` 

### Ignore lint warnings on generated files
Depending on your lint options, Neat Generator may cause your linter to report warnings.

The solution to this problem is to tell the linter to ignore generated files, by modifying your analysis_options.yaml:
```
analyzer:
  exclude:
    - "**/*.nt.dart"
```

### Space Widgets
Space Widget represents a blank space in your app. This widget inherit from SizedBox and define constructors with pre-filled height and width values, based on data in your value class.
By default, space widgets are generated from `static const double` fields of a class annotated `@Neat.generate` and that starts with "space". The generator will name widgets according to their corresponding fieldName.
There are few class annotations for different use case and you can customize the generator behavior by adding some parameters to the annotation. More details <a href="https://github.com/Pierre2tm/neat/blob/main/packages/neat/doc/generator.md#space-generator">here</a>.

#### Generated constructors
```dart
const SpaceX();   //SizedBox(width: X, height: X);
const SpaceX.h(); //SizedBox(width: 0, height: X);
const SpaceX.w(); //SizedBox(width: X, height: 0);
```

#### Example
*dimensions.dart*
```dart
import 'package:neat/generator.dart';

part 'dimensions.nt.dart';

@Neat.generate
class Dimensions {
  static const double spaceSmall = 21;
  static const double spaceMedium = 34;
  static const double spaceBig = 55;
}
```
*main.dart*
```dart
import 'dimensions.dart';

const SpaceSmall();     //SizedBox(height: 21,  width: 21);
const SpaceMedium.w();  //SizedBox(height: 0,   width: 34);
const SpaceBig.h();     //SizedBox(height: 55,  width: 0);
```

### Padding helpers
PaddingHelpers inherit from EdgeInsets class and define new constructors with pre-filled values based on data in your value class.
By default, helpers are generated from `static const double` fields of a class annotated `@Neat.generate` and that starts with "padding". The generator will name classes according to their corresponding fieldName.
There are few class annotations for different use case and you can customize the generator behavior by adding some parameters to the annotation. More details <a href="https://github.com/Pierre2tm/neat/blob/main/packages/neat/doc/generator.md">here</a>.

#### Generated constructors
```dart
const PaddingX(top | left | right | bottom);    //EdgeInsets.only(top: X, left: X, right: X, bottom: X); can be disabled
const PaddingX.all();                           //EdgeInsets.all(X);
const PaddingX.horizontal();                    //EdgeInsets.symmetric(horizontal: X);
const PaddingX.vertical();                      //EdgeInsets.symmetric(vertical: X);
const PaddingX.only(                            //EdgeInsets.only(
  top: true,                                    //  top: X,
  left: true,                                   //  left: X,
  right: true,                                  //  right: X,
  bottom: true,                                 //  bottom: X,
);                                              //);
```
Note that the binary flag constructor `Padding(top | left | right | bottom)` use generated constants (top, left, right, bottom) to works. If it causing conflicts in your code, you can disable it by using `generateBinaryFlagConstructor = false`. More details about generator configuration <a href="https://github.com/Pierre2tm/neat/blob/main/packages/neat/doc/generator.md#padding-generator">here</a>.

#### Example
*dimensions.dart*
```dart
import 'package:neat/generator.dart';

part 'dimensions.nt.dart';

@Neat.generate
class Paddings {
  static const double padding1 = 21;
  static const double padding2 = 13;
  static const double padding3 = 8;
  static const double padding4 = 5;
  static const double padding5 = 3;
}
```

*main.dart*
```dart
import 'dimensions.dart';

Padding(padding: Padding1.all());                       //EdgeInsets.all(21)
Padding(padding: Padding2.horizontal());                //EdgeInsets.symmetric(horizontal: 13)
Padding(padding: Padding3.vertical());                  //EdgeInsets.symmetric(vertical: 8)
Padding(padding: Padding4(top | left));                 //EdgeInsets.only(top: 5, left: 5)
Padding(padding: Padding5.only(top: true, left: true)); //EdgeInsets.only(top: 5, left: 5)
```
# Contributions
**Wants to contribute ?** I'm happy to discuss about what feature to add next !

I've published this package recently, helps in one of the following area is appreciated:
 * **Improving the README**: English is not my native language, PRs to improve the quality of the readme are welcome !
 * **Test coverage**: Adding some tests, especially for the fieldFilter / widgetNameExtractor is a top priority.
 * **Improve the code generator configuration**: Make code generators more flexible by adding more generation options. Parser is actually pretty basic and it probably needs to be refactored.

If you like Neat, don't forget to leave a ⭐️ on the repo and share the package !