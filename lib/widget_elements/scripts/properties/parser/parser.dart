import 'models.dart';
import 'dart:io';
import 'package:yaml/yaml.dart';

List<String> parseExternal() {
  var file = File("../prop_config.yaml");
  String configContent = file.readAsStringSync();
  YamlMap parsedYaml = loadYaml(configContent);
  return List.from(parsedYaml["external"]);

}

List<ParsedProp> parseEnumProperties() {
  var file = File("../prop_config.yaml");
  String configContent = file.readAsStringSync();
  YamlMap parsedYaml = loadYaml(configContent);
  YamlMap properties = parsedYaml["properties"];


  return properties.keys.map((key) {
    var val = properties[key];
    return _parseProp(key, val);
  }).where((it) => it != null).toList();

}

ParsedProp _parseProp(String key, dynamic val) {
  if (val is String) {
    // SomeProperty: enum
    assert(val == "enum");
    if(val == "enum") {
      return ParsedEnum(key);
    }
  } else if (val is YamlMap) {
    var type = val["type"];
    if (type == "enum") {
      return ParsedEnum(key);
    }

    if(type is YamlMap) {
      if(type.containsKey("composite")) {
        return _parseObjectProp(key, type["composite"], val["wrapper"]?? key);
      }
    }
    assert(false, type.runtimeType);
  }
}


ObjectProp _parseObjectProp(String name, YamlMap map, String wrapper) {
  Map<String, BaseProp> res = Map();
  for(String key in map.keys) {
    if(map[key] is YamlMap) {
      Map propMap = map[key];
      res[key] = BaseProp(
          name: key,
          type: (propMap["type"] as String),
          extras: Map.of(propMap)..remove("type"),
      );
    } else {
      res[key] = BaseProp(
        name: key,
        type: (map[key] as String)
      );
    }
  }
  return ObjectProp(name, res, wrapper);
}

