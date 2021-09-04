import 'package:build/build.dart';

Builder neat_builder(BuilderOptions options) {
  print("yo test------------------------------");

  return SpaceBuilder();
}

class SpaceBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.gen']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    print(
      "---------------------------------------------Neat:build runner fonction !",
    );

    // Each `buildStep` has a single input.
    var inputId = buildStep.inputId;

    // Create a new target `AssetId` based on the old one.

    var copy = inputId.changeExtension(".gen");
    // var copy = inputId.addExtension(".generated");
    var contents = await buildStep.readAsString(inputId);

    // Write out the new asset.
    await buildStep.writeAsString(copy, contents);
  }
}
