
/// A parsed property fom the YAML
abstract class ParsedProp {

  final String name;

  ParsedProp(this.name);

  String get serialize;
}

/// An enum
class ParsedEnum extends ParsedProp {

  ParsedEnum(String name): super(name);

  String get serialize => "";


}


/// A property which can be constructed with different constructors
class ParsedDifferentConstructorProp extends ParsedProp {
  ParsedDifferentConstructorProp(String name) : super(name);

  @override
  String get serialize => throw UnimplementedError();


}


/// A composite object, which is itself made of different objects
class ObjectProp extends ParsedProp {

  final Map<String, BaseProp> subProperties;
  final String wrapper;

  ObjectProp(String name, this.subProperties, this.wrapper): super(name);


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'wrapper': wrapper,
      'props': subProperties.keys.map((key) {
        var value = subProperties[key];
        return value.toMap()..["objectPropName"] = name;
      }).toList()
    };
  }

  @override
  // TODO: implement serialize
  String get serialize => throw UnimplementedError();
}

class BaseProp extends ParsedProp {

  final String type;
  final Map<dynamic, dynamic> extras;


  BaseProp({this.type, String name, this.extras = const {}}): super(name);

  String get uppercaseType => type.firstUpper();

  bool get isPrimitive => type == "String" || type == "int" || type == "bool" || type == "double";


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'uType': uppercaseType,
      'additional': extras?.keys?.map((key) {
        var extraValue = extras[key];
        return {
          'name': key,
          'value': extraValue,
        };
      })?.toList()?? [],
    };
  }

  @override
  String get serialize => throw UnimplementedError();
}


extension _Upper on String {

  String firstUpper() {
    String me = this;
    return this.replaceRange(0, 1, me[0].toUpperCase());
  }

}