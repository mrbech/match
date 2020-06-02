import 'package:analyzer/dart/element/element.dart';
import 'package:match_generator/utils.dart';

String generateClass(ClassElement c) {
  final sub = c.library.topLevelElements
      .where((e) =>
          e is ClassElement &&
          e.allSupertypes.map((i) => i.element).contains(c))
      .toList();
  return '''
      extension ${c.name}Match on ${c.name} {
        T match<T>({
          T Function() any,
          ${sub.map(namedFunctionArgument).join(',\n')}
        }) {
          final v = this;
          ${sub.map(typeMatch).join('\n')}

          if(any != null) {
            return any();
          }

          throw Exception('${c.name}.match failed, found no match for: \$this');
        }
      }
    ''';
}

String namedFunctionArgument(Element c) {
  return 'T Function(${c.name}) ${c.name.toCamelCase()}';
}

String typeMatch(Element c) {
  return '''
      if(v is ${c.name} && ${c.name.toCamelCase()} != null) { 
        return ${c.name.toCamelCase()}(v);
      }
    ''';
}
