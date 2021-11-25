import 'package:neat_annotations/src/generate_padding_annotation.dart';

import 'generate_padding_annotation.dart';
import 'generate_space_annotation.dart';

class NeatGenerate {
  const NeatGenerate({
    ///padding helpers generator options
    ///if null, padding helpers will not be generated
    this.padding = const GeneratePadding(),

    ///space widgets generator options
    ///if null, space widgets will not be generated
    this.space = const GenerateSpace(),
  });

  final GeneratePadding? padding;
  final GenerateSpace? space;
}
