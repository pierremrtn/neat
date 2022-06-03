import 'package:flutter/material.dart';

import 'package:neat/neat.dart';
import 'dimensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neat Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: context.subtitle1("neat"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Material 3
              context.displayLarge('displayLarge'),
              context.displayMedium('displayMedium'),
              context.displaySmall('displaySmall'),
              context.headlineLarge('headlineLarge'),
              context.headlineMedium('headlineMedium'),
              context.headlineSmall('headlineSmall'),
              context.titleLarge('titleLarge'),
              context.titleMedium('titleMedium'),
              context.titleSmall('titleSmall'),
              context.bodyLarge('bodyLarge'),
              context.bodyMedium('bodyMedium'),
              context.bodySmall('bodySmall'),
              context.labelLarge('labelLarge'),
              context.labelMedium('labelMedium'),
              context.labelSmall('labelSmall'),

              const SpaceSmall(),

              // Material 2
              context.headline1('headline1'),
              context.headline2('headline2'),
              context.headline3('headline3'),
              context.headline4('headline4'),
              context.headline5('headline5'),
              context.headline6('headline6'),
              context.subtitle1('subtitle1'),
              context.subtitle2('subtitle2'),
              context.bodyText1('bodyText1'),
              context.bodyText2('bodyText2'),
              context.caption('caption'),
              context.buttonText('button'),
              context.overline('overline'),

              const SpaceBig(),
              context.titleLarge('padding all'),
              Container(
                padding: const PaddingSmall(),
                color: Colors.redAccent,
                child: Container(
                  color: Colors.amber,
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                padding: const PaddingSmall.all(),
                color: Colors.redAccent,
                child: Container(
                  color: Colors.amber,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding horizontal'),
              Container(
                padding: const PaddingSmall.horizontal(),
                color: Colors.greenAccent,
                child: Container(
                  color: Colors.green,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding vertical'),
              Container(
                padding: const PaddingSmall.vertical(),
                color: Colors.redAccent,
                child: Container(
                  color: Colors.amber,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge("padding symmetric"),
              Container(
                padding: const PaddingSmall.symmetric(horizontal: true),
                color: Colors.greenAccent,
                child: Container(
                  color: Colors.green,
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                padding: const PaddingSmall.symmetric(vertical: true),
                color: Colors.redAccent,
                child: Container(
                  color: Colors.amber,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding top'),
              Container(
                padding: const PaddingSmall(top),
                color: Colors.blue,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                padding: const PaddingSmall.top(),
                color: Colors.yellow,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding left'),
              Container(
                padding: const PaddingSmall.left(),
                color: Colors.yellow,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                padding: const PaddingSmall(left),
                color: Colors.blue,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding right'),
              Container(
                padding: const PaddingSmall.right(),
                color: Colors.yellow,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                padding: const PaddingSmall(right),
                color: Colors.blue,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding bottom'),
              Container(
                padding: const PaddingSmall.bottom(),
                color: Colors.yellow,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                padding: const PaddingSmall(bottom),
                color: Colors.blue,
                child: Container(
                  color: Colors.lightGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding all using only'),
              Container(
                padding: const PaddingSmall.only(
                  top: true,
                  left: true,
                  right: true,
                  bottom: true,
                ),
                color: Colors.lightGreenAccent,
                child: Container(
                  color: Colors.lightBlueAccent,
                  height: 20,
                  width: 20,
                ),
              ),
              const SpaceSmall(),
              context.titleLarge('padding none using only'),
              Container(
                padding: const PaddingSmall.only(
                  top: false,
                  left: false,
                  right: false,
                  bottom: false,
                ),
                color: Colors.lightGreenAccent,
                child: Container(
                  color: Colors.lightBlueAccent,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
