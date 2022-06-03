## 0.2.2
* fix: ran flutter format on neat.dart

## 0.2.1
* fix: readme summary broken links

## 0.2.0
* feature: Added material 3 text helpers
* **[Breaking change]** padding generator default constructor now default to EdgeInsets.all(padding) instead of EdgeInsets.zero
* feature: New padding helper constructors:
  * Padding.left();
  * Padding.top();
  * Padding.right();
  * Padding.bottom();
* fix: Default padding constructor is now generated even if generateBinaryFlagConstructor is false.
* fix: fix dart style mistakes
* doc: Readme has been re-written
* doc: add code documentation
* doc: add example

## 0.1.1
Remove <br/> in README.md

## 0.1.0
Split package in 3 (`neat`, `neat_generator` and `neat_annotations`).
Now you should use neat package as runtime dependency and neat_generator as dev dependency.
`neat_annotations` package is used under the hood, you have no need to declare this dependency yourself.

## 0.0.2
fixes:
- remove environnement flutter version constraint to enable null-safety badge on pub.dev 

## 0.0.1
initial release

### Utilities
* Material Texts utilities
* ThemeData accessors

### Code Generator
* Space widget generator
* Padding Helpers generator
