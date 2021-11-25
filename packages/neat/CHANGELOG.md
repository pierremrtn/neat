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
