import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  const Headline1(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class Headline2 extends StatelessWidget {
  const Headline2(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}

class Headline3 extends StatelessWidget {
  const Headline3(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

class Headline4 extends StatelessWidget {
  const Headline4(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class Headline5 extends StatelessWidget {
  const Headline5(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class Headline6 extends StatelessWidget {
  const Headline6(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class Subtitle1 extends StatelessWidget {
  const Subtitle1(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}

class Subtitle2 extends StatelessWidget {
  const Subtitle2(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}

class BodyText1 extends StatelessWidget {
  const BodyText1(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class BodyText2 extends StatelessWidget {
  const BodyText2(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}

class Caption extends StatelessWidget {
  const Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.caption,
    );
  }
}

class Overline extends StatelessWidget {
  const Overline(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.overline,
    );
  }
}
