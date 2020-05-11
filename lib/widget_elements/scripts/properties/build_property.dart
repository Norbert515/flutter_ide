import 'dart:io';
import 'package:widget_maker_2_0/widget_elements/scripts/properties/generators/enum_generator.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/properties/generators/object_prop_generator.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/properties/parser/models.dart';




void writeObjectProperties(List<ObjectProp> objects) {
  File enumFile = File("../generated/properties/objects.dart");

  var code = ObjectPropGenerator.generateAllObjectCodes(objects);

  enumFile.writeAsStringSync(code);
}

void writeEnumProperties(List<ParsedEnum> objects) {
  File enumFile = File("../generated/properties/enums.dart");

  var code = EnumGenerator.generateAllEnumCodes(objects);

  enumFile.writeAsStringSync(code);
}