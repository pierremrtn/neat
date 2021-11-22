# Neat 
Welcome to Neat, a utility package that helps doing cleaner Flutter code.

Flutter framework is very verbose and widget trees quickly becomes difficult to read. Neat package is designed to make the code easier to read by introducing convenient solutions for common patterns without requiring any additional work from your part.

| **neat** | [![pub package](https://img.shields.io/pub/v/riverpod.svg?label=riverpod&color=blue)](https://pub.dartlang.org/packages/riverpod) |
|----------|-----------------------------------------------------------------------------------------------------------------------------------|

Actually, neat provide 4 types of helpers and widgets:
- **Text helpers** that helps you create headlines/subtitles/bodyTexts
- **Theme accessor** for easily access theme's data
- **Space widgets**, a blank space widgets, generated from your own data, that inherit from SizedBox
- **Padding helpers**, for easily creating padding. Helpers are generated from your own data

take this example, without neat:
```dart
import 'dimensions.dart'; //you declare constants in this file

Text(
  "Flutter is awesome but...",
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
    "...its a little bit verbose",
    style: Theme.of(context).textTheme.bodyText1?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    ),
  ),
),
```

with Neat could write:
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
## Install

Install Neat by running following command:
```
flutter pub add neat
```
If you want to use the Neat's code generator, you will need your typical build_runner/code-generator setup. Run the following command to add build_runner package to your dev dependencies:
```
flutter pub add build_runner -dev
```
Theses will add the following dependencies to your `pubspec.yaml` file:
```
# pubspec.yaml
dependencies:
  neat:

dev_dependencies:
  build_runner:
```

# Features

Neat has to distinct parts:
* A collection of helpers and widgets, that you can import with `import 'package:neat/neat.dart';`

* A code generator, that you can import with `import 'package:neat/generator.dart';`

## Text helpers

In most flutter applications, you define TextStyles in your material `ThemeData` and then to create, for example, a Headline1, you should do the following:
```
Text(
    "Headline1",
    style: Theme.of(context).textTheme.headline1,
),
```
If you wants to override some properties of the style its get even worth:
```
Text(
  "Headline1",
  style: Theme.of(context)
      .textTheme
      .headline1
      ?.copyWith(color: Colors.red),
),
```
Neat introduce a collection of extension on `BuildContext` that simplify the creation of headlines and other types of text defined in material textTheme:
```
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
```
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

All methods have same properties than regular Text widget:
```
context.headline1(
    Headline1,
    key: key,
    style: style,
    strutStyle: strutStyle,
    textAlign: textAlign,
    textDirection: textDirection,
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    textScaleFactor: textScaleFactor,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior,
    weight: weight,
),
```

## Theme accessors
Without Neat, you access ThemeData, textTheme and colorScheme in the following way:
```
Theme.of(context);
Theme.of(context).textTheme;
Theme.of(context).colorScheme;
```
Neat introduce this alternative way to access your theme:
```
import 'package:neat/neat.dart';

context.theme;
context.textTheme;
context.colorScheme;
```

## Neat Generator
When you want to keep your spacing and padding consistent across your app, you often end up with a Dimension class holding all your variables at the same place, like this:
```dart
class Dimensions {
    static double paddingSmall = 8;
    static double paddingMedium = 13;
    static double paddingBig = 21;

    static double spaceSmall = 13;
    static double spaceMedium = 21;
    static double spaceBig = 34;
}
```
Then you use theses value in your app:
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
Neat helps you pushing it further by generating specialized helpers and widgets based on your data class, without wasting time coding it yourself:
```dart
//Generated Space widget, inherit from SizedBox class,
const SpaceSmall(),

Padding(
  //Generated Padding helper, inherit form EdgeInsets class
  padding: PaddingMedium(top | left),
  child: ...,
)
```
The generator is flexible and let you configure generated widget names, filters what field to include or exclude from generation, etc. See Generator Options for more details about generation options. 

### basic usage

Create a Dimensions class and annotate it with `@Neat.generate`. Neat generator will generate both spacing widgets and padding helpers for classes annotated with it.

**dimensions.dart**
```dart
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
I recommend to use the option `--delete-conflicting-outputs` to avoid problems during builds.

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
Space Widget represent a blank space in your app. This widget inherit from SizedBox and define constructors with pre-filled height and width values, based on data in your value class.
By default, space widgets are generated from `static const double` fields of a class annotated `@Neat.generate` and that starts with "space". The generator will name widgets according to their fieldName.
There are few class annotations for different use case and you can customize the generator behavior by adding some parameters to the annotation. More details <a href="/doc/generator.md">here</a>.

#### Generated constructors
```dart
const SpaceX();   //SizedBox(width: X, height: X);
const SpaceX.h(); //SizedBox(width: 0, height: X);
const SpaceX.w(); //SizedBox(width: X, height: 0);
```

#### Example
**dimensions.dart**
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
**main.dart**
```dart
import 'dimensions.dart';

const SpaceSmall();     //h: 21, w: 21
const SpaceMedium.w();  //h: 0, w: 34
const SpaceBig.h();     //h: 55, w: 0
```

### Padding helpers
PaddingHelpers inherit from EdgeInsets class and define new constructors with pre-filled values based on data in your value class.
By default, space widgets are generated from `static const double` fields of a class annotated `@Neat.generate` and that starts with "padding". The generator will name classes according to their fieldName.

#### Generated constructors
```dart
//Binary flag constructor.
//top, left, right and bottom are constants generated by Neat.
//you can disable this constructor and constants generation
//with generateBinaryFlagConstructor set to false
const PaddingX(top | left | right | bottom);  //EdgeInsets.only(top: X, left: X, right: X, bottom: X);

const PaddingX.all();                         //EdgeInsets.all(X);

const PaddingX.horizontal();                  //EdgeInsets.symmetric(horizontal: X);

const PaddingX.vertical();                    //EdgeInsets.symmetric(vertical: X);

const PaddingX.only(                          //EdgeInsets.only(top: X, left: X, right: X, bottom: X);
  top: true,
  left: true,
  right: true,
  bottom: true,
);
```

#### Example
**dimensions.dart**
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

**main.dart**
```dart
import 'dimensions.dart';

Padding(
  padding: Padding1.all(),                       //EdgeInsets.all(21)
);
Container(
  padding: Padding2.horizontal(),                //EdgeInsets.symmetric(horizontal: 13)
);
Padding(
  padding: Padding3.vertical(),                  //EdgeInsets.symmetric(vertical: 8)
);
Padding(
  padding: Padding4(top | left),                 //EdgeInsets.only(top: 5, left: 5)
);
Padding(
  padding: Padding5.only(top: true, left: true)   //EdgeInsets.only(top: 5, left: 5)
);
```
# Contributions
**Wants to contribute ?** I'm happy to discuss about what feature to add next !

I've published this package recently, help in one of the following area is appreciated:
 * **Improving the README**: English is not my native language, any helps to improve the quality of the readme are welcome !
 * **Test coverage**: Add some tests, especially for the fieldFilter / widgetNameExtractor is a top priority.
 * **Improve the code generator configuration**: Make code generators more flexible by adding more generation options. Parser is actually pretty basic and it probably need a refacto.

If you like Neat, don't forget to leave a ⭐️ on the repo and share the package !

<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
