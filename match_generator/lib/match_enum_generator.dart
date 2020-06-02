import 'package:analyzer/dart/element/element.dart';
import 'package:match_generator/utils.dart';

String generateEnum(ClassElement c) {
  final values = c.fields.where((f) => f.isEnumConstant);
  return '''
      extension ${c.name}Match on ${c.name} {
        T match<T>({
          T Function() any,
          ${values.map(namedFunctionArgument).join(',\n')}
        }) {
          final v = this;
          ${values.map((v) => enumValueMatch(c, v)).join('\n')}

        if(any != null) {
          return any();
        }

        throw Exception('${c.name}.match failed, found no match for: \$this');
      }
}
  ''';
}

String namedFunctionArgument(FieldElement f) {
  return 'T Function() ${f.name.toCamelCase()}';
}

String enumValueMatch(ClassElement c, FieldElement f) {
  return '''
    if(v == ${c.name}.${f.name} && ${f.name.toCamelCase()} != null) {
      return ${f.name.toCamelCase()}();
    }
  ''';
}
