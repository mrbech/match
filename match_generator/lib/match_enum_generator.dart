import 'package:analyzer/dart/element/element.dart';
import 'package:match_generator/utils.dart';

String generateEnum(ClassElement c) {
  final values = c.fields.where((f) => f.isEnumConstant);
  return '''
      extension ${c.name}Match on ${c.name} {
        T match<T>({
          ${values.map(namedFunctionArgument).map((n) => 'required $n').join(',\n')}
        }) {
          final v = this;
          ${values.map((v) => enumValueMatch(c, v)).join('\n')}

          throw Exception('${c.name}.match failed, found no match for: \$this');
        }

        T matchAny<T>({
          required T Function() any,
          ${values.map(optionalNamedFunctionArgument).join(',\n')}
        }) {
          final v = this;
          ${values.map((v) => optionalEnumValueMatch(c, v)).join('\n')}

          return any();
        }
      }
  ''';
}

String optionalNamedFunctionArgument(FieldElement f) {
  return 'T Function()? ${f.name.toCamelCase()}';
}

String namedFunctionArgument(FieldElement f) {
  return 'T Function() ${f.name.toCamelCase()}';
}

String enumValueMatch(ClassElement c, FieldElement f) {
  return '''
    if(v == ${c.name}.${f.name}) {
      return ${f.name.toCamelCase()}();
    }
  ''';
}

String optionalEnumValueMatch(ClassElement c, FieldElement f) {
  return '''
    if(v == ${c.name}.${f.name} && ${f.name.toCamelCase()} != null) {
      return ${f.name.toCamelCase()}();
    }
  ''';
}
