# Neat

A collection of opinionated convenient widgets.
TODO: better readme

## How to use

### Text widgets
Widgets that wrap text into a `Text` widget with according style.

```
    class Headline1 extends StatelessWidget {
      const Headline1(this.text);

      final String text;

      @override
      Widget build(BuildContext context) {
        return Text(text, style: Theme.of(context).textTheme.headline1);
      }
    }
```

Widgets follows `ThemeData` text styles typographies.
There is one widget for each material style exepted `button`.

```
    //Headldines
    Headline1("H1"),
    Headline2("H2"),
    Headline3("H3"),
    Headline4("H4"),
    Headline5("H5"),
    Headline6("H6"),

    //Subtitle
    Subtitle1("Subtitle1"),
    Subtitle2("Subtitle2"),

    //BodyText
    BodyText1("Body 1"),
    BodyText2("Body 2"),

    //Caption
    Caption("caption"),

    //Overline
    Overline("overline"),
```

### Generated widget

TODO: why we should use generation
TODO: build_runner setup

#### Space widget
Widgets that define a fixed space in UI. Space widget encapsule a SizedBox with constant value.
The goal is to avoid boilerplate code like `SizedBox(width: MyTheme.size.small)` when using a custom app theme.
Theses widget are generated using build_runner and anotation. 

define your app class theme and anotate it with neat's anotations (`dims.dart`)
```
import 'package:neat/neat.dart';

@neat
class Dim {
  @nt_space
  static const Map<String, double> spaces = {
    "small": 8,
    "medium": 16,
    "big": 32
  };
}
```
then run build_runner `flutter pub run build_runner build --delete-conflicting-outputs`.
It will generate a `.nt.dart` file containeing generated `Space` widgets.
```
    class SpaceSmall extends StatelessWidget {
    const SpaceSmall()
        : width = 8,
          height = 8;

    const SpaceSmall.w()
        : width = 8,
          height = 0;

    const SpaceSmall.h()
        : width = 0,
          height = 8;

    final double width;
    final double height;

    @override
    Widget build(BuildContext context) {
      return SizedBox(width: width, height: height);
    }
```
You can then import `dims.nt.dart` to use them.
```    
    SpaceSmall(), //SizedBox(width: 8, height: 8)    
    SpaceMedium.w(), //SizedBox(width: 16, height: 0)
    SpaceBig.h(), //SizedBox(width: 0, height: 32)
```
You can aslo use a list to generate `Space`s. Names will be suffixed with space's index.
```
@neat
class Dim {
  @nt_space
  static const List<double> spaces = [8, 16, 32];
}

...

Space1(), //SizedBox(width: 8, height: 8)
Space2.w(), //SizedBox(width: 16, height: 0)
Space3.h(), //SizedBox(width: 0, height: 32)
```