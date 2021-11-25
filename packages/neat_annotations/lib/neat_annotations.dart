library neat_annotations;

import 'package:neat_annotations/src/generate_padding_annotation.dart';
import 'package:neat_annotations/src/generate_space_annotation.dart';
import 'package:neat_annotations/src/global_generator_annotation.dart';

export 'src/neat_class_annotation.dart';
export 'src/global_generator_annotation.dart';
export 'src/generate_padding_annotation.dart';
export 'src/generate_space_annotation.dart';

class Neat {
  static const generate = NeatGenerate();
  static const generateSpace = GenerateSpace(
    generateForFieldStartingWith: null,
  );
  static const generatePadding = GeneratePadding(
    generateForFieldStartingWith: null,
  );
}
