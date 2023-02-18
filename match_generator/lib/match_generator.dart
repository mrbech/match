library match_generator;

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:match/match.dart';
import 'package:source_gen/source_gen.dart';
import 'package:match_generator/match_class_generator.dart';
import 'package:match_generator/match_enum_generator.dart';

Builder match(BuilderOptions options) =>
    SharedPartBuilder([MatchExtensionGenerator()], 'match');

class MatchExtensionGenerator extends GeneratorForAnnotation<Match> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is EnumElement) {
      return generateEnum(element);
    }
    if (element is ClassElement) {
      return generateClass(element);
    }
    throw Exception('@match must be used on a class');
  }
}
