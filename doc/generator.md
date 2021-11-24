# Neat Generator

## Usage
To use Neat's code generator, you will need your typical build_runner/code-generator setup. Run the following command to add build_runner package to your dev dependencies:
```
flutter pub add build_runner -dev
```

Note that like most code-generators, Neat will need you to both import the annotation (meta) and use the part keyword on the top of your files.
You can import code generator's annotation with `import 'package:neat/generator.dart';`.
As such, a file that wants to use Neat's code generator will start with:

```dart
import 'package:neat/generator.dart';

part 'my_file.nt.dart';
```

to run the generator, use the following command: `flutter pub run build_runner build`.
I recommend using the option `--delete-conflicting-outputs` to avoid problems during builds.

## Different generators
Neat generator is composed of 3 distinct generator. :
* **Space generator** will run on class annotated with @Neat.generateSpace. It generate space widget.
* **Padding generator** will run on class annotated with @Neat.generatePadding. It generate padding helper.
* **Global generator** will run on class annotated with @Neat.generate. It regroup every generators at once.

## global generator

By default, global generator generate Space widgets for each field that starts with "space" and padding helper for each field that starts with "padding".

The global generator call others neat generators under the hood. Its purpose is to let you use all generator at once with only one annotation.

Global generator will run on every class annotated with `@Neat.generate` or `@NeatGenerator()`.
`@Neat.generate` syntax is just a constant NeatGenerator() instance with default values. Using `@NeatGenerator` syntax directly let you customize generator's behavior.

### available options

```dart
@NeatGenerator(
    ///space widgets generator options
    ///if null, space widgets will not be generated
    space = const GenerateSpace(),

    ///padding helpers generator options
    ///if null, padding helpers will not be generated
    padding = const GeneratePadding(),
  });
```

**space: GenerateSpace? = const GenerateSpace()** Space Generator options. See <a href="#space-widget-generator-options">space generator options</a> for more details. If you set space parameter to null, Space widget will not be generated.

**padding: GeneratePadding? = const GeneratePadding()** Padding Generator options. See <a href="#padding-helpers-generator-options">padding generator options</a> for more details. If you set padding parameter to null, Padding helpers will not be generated.

### example
*input*
```dart
@NeatGenerate(
  //custom padding generator config
  padding: GeneratePadding(
    classRadical: "P",
    generateForFieldStartingWith: "padding",
    removePrefix: true,
    generateBinaryFlagConstructor: false,
  ),
  //disable space generation
  space: null,
)
class Dimensions {
  static const double padding1 = 1;
  static const double padding2 = 2;
  static const double padding3 = 3;

  //excluded since it doesn't starts with "padding"
  static const double sizeSmall = 1;
}
```

## space generator

Space widget generator use `static const double` fields of a class to generate space widgets that represent blank space in your app and inherit from SizedBox.

Space generator will run on every class annotated with `@Neat.generateSpace` or `@GenerateSpace()`.
- `@GenerateSpace()` annotation let you pass generator configuration as constructor parameter. Default configuration will generate a Space widget for every class fields that starts with "space". More details available options <a href="Space-widget-generator-options">here</a>.

- `@Neat.generateSpace` is an instance of `GenerateSpace` configured to generate space widget for every field of the class, no matter how they are named. This annotation is best suited if you want to separate you Spacing class from your other Dimensions class.

### Space widget generator options
**classRadical: String? = "Space"**<br/>
The base name of widget that will be generated.

**generateForFieldStartingWith: String? = "space"**<br/>
If not-null, generator will only generate Space widget for field where `fieldName.startsWith(generateForFieldStartingWith) == true`. If null, every fields of the class will be used to generate a corresponding widget.

**removePrefix: bool = false**<br/>
Remove prefix specified by generateForFieldStartingWith parameter form fieldName.

**radicalFirst: bool = true**<br/>
Specify if classRadical should be printed before or after the fieldName 

**avoidPrefixRepetition: bool = true**<br/>
If true, remove the beginning of field name if its match `classRadical`.

### example
*input*
```dart
import 'package:neat/generator.dart';

@GenerateSpace(
  classRadical: "Spacing",
  generateForFieldStartingWith: "s",
  removePrefix: true,
)
class Spaces {
  static const double s1: 5,
  static const double s2: 8,
  static const double s3: 13,
  static const double sSpecial: 42,
}
```
*output*
```dart
Space1();
Space2();
Space3();
SpaceSpecial();
```

### Implementation details
Generated space widgets will follow this structure, with `X` set to fieldName after been transformed accordingly to generator options and `value` set to field's value:
```dart
class SpaceX extends SizedBox {
  const SpaceSmall({Key? key})
      : super(
          height: value,
          width: value,
          key: key,
        );

  const SpaceX.w({Key? key})
      : super(
          height: 0,
          width: value,
          key: key,
        );

  const SpaceX.h({Key? key})
      : super(
          height: value,
          width: 0,
          key: key,
        );
}
```
## padding generators
Padding generator use `static const double` fields of a class to generate padding helper class that helps construct EdgeInsets with pre-filled values.

Padding generator will run on every class annotated with `@Neat.generatePadding` or `@GeneratePadding()`.
- `@GeneratePadding()` annotation let you pass generator configuration as constructor parameter. Default configuration will generate a padding helper class for every fields that starts with "padding". More details about available options <a href="Padding-helper-generator-options">here</a>.

- `@Neat.generateSpace` is an instance of `GenerateSpace` configured to generate space widget for every field of the class, no matter how they are named. This annotation is best suited if you want to separate you Spacing class from your other Dimensions class.

### Padding helper generator options

**generateBinaryFlagConstructor: bool = true**<br/>
Specify if generator should generate binary flag constructor (`PaddingX(top | left | right | bottom)`)

**classRadical: String? = "Padding"**<br/>
The base name of helper that will be generated.

**generateForFieldStartingWith: String? = "space"**<br/>
If not-null, generator will only generate Space widget for field where `fieldName.startsWith(generateForFieldStartingWith) == true`. If null, every fields of the class will be used to generate a corresponding helper.

**removePrefix: bool = false**<br/>
Remove prefix specified by generateForFieldStartingWith parameter form fieldName.

**radicalFirst: bool = true**<br/>
Specify if classRadical should be printed before or after the fieldName 

**avoidPrefixRepetition: bool = true**<br/>
If true, remove the beginning of field name if its match `classRadical`.

### implementation details
Generated padding helpers will follow this structure, with `X` set to fieldName after been transformed accordingly to generator options and `value` set to field's value: 
```dart
class PaddingX extends EdgeInsets {
  const PaddingX([int padding = 0])
      : super.only(
          left: padding & left == left ? value : 0,
          right: padding & right == right ? value : 0,
          top: padding & top == top ? value : 0,
          bottom: padding & bottom == bottom ? value : 0,
        );

  const PaddingX.all() : super.all(value);

  const PaddingX.only(
      {bool left = false,
      bool right = false,
      bool top = false,
      bool bottom = false})
      : super.only(
          left: left ? value : 0,
          right: right ? value : 0,
          top: top ? value : 0,
          bottom: bottom ? value : 0,
        );

  const PaddingX.horizontal()
      : super.symmetric(horizontal: value, vertical: 0);

  const PaddingX.vertical() : super.symmetric(vertical: value, horizontal: 0);

  const PaddingX.symmetric({bool horizontal = false, bool vertical = false})
      : super.symmetric(
            horizontal: horizontal ? value : 0, vertical: vertical ? value : 0);
}
```