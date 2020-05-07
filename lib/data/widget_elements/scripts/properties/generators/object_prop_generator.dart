import 'dart:io';
import 'package:mustache/mustache.dart';
import 'package:widget_maker_2_0/data/widget_elements/scripts/properties/parser/models.dart';

class ObjectPropGenerator {

  static String generateAllObjectCodes(List<ObjectProp> objectProps) {
    String source = File("properties/templates/all_object_properties.tmpl").readAsStringSync();

    List<String> codes = objectProps.map((it) => generateObjectPropCode(it)).toList();
    var template = Template(source, htmlEscapeValues: false);
    return template.renderString({
      'objectProps': codes.map((it) => {"code": it}),
    });
  }

  static String generateObjectPropCode(ObjectProp objectProp) {
    String source = File("properties/templates/object_property.tmpl").readAsStringSync();

    var template = Template(source, htmlEscapeValues: false);
    return template.renderString(objectProp.toMap());
  }
}
