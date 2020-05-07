import 'package:code_builder/code_builder.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';

/// Helper for code generation
///
/// Similar to refer(name).newInstance(...) but it removes null values from the
/// expression lists and maps
Expression constructor(String name, Iterable<Expression> positionalArguments, [
  Map<String, Expression> namedArguments = const {},
]) {

  namedArguments.removeWhere((it, that) {
    return that == null;
  });


  Iterable<Expression> cP = positionalArguments.where((it) => it != null);
  return refer(name).newInstance(cP, namedArguments);
}


Expression propertyConstructor(String name, Iterable<MProperty> attributes, [Map<String, Expression> added]) {

  Map<String, Expression> named = attributes.where((it) {
    assert(it.isNamed != null, "${it.runtimeType} return null for isNamed");

    return it.isNamed && !it.shouldBeOmitted;
  }).where((it) => it.value != null).toList().asMap()
      .map((key, value) {
    return MapEntry(value.name, value.toCode());
  });

  if(added != null) {
    named.addAll(added);
  }

  Iterable<Expression> positional = attributes.where((it) {
    return !it.isNamed && !it.shouldBeOmitted;
  })
      .map((it) => it.toCode());

  return refer(name).newInstance(positional, named);
}

String expressionToCode(Expression expression) {
  final emitter = DartEmitter();
  return expression.accept(emitter).toString();
}

class CodeBuilder {











}