import 'package:mustache/mustache.dart';
import 'dart:io';
import 'package:widget_maker_2_0/widget_elements/scripts/properties/parser/models.dart';

class EnumGenerator {




  static String generateAllEnumCodes(List<ParsedEnum> enumStrings) {
    String source = File("properties/templates/all_enum_properties.tmpl").readAsStringSync();

    List<String> codes = enumStrings.map((it) => generateEnumCode(it.name)).toList();
    var template = Template(source, htmlEscapeValues: false);
    return template.renderString({
      'enums': codes.map((it) => {"code": it}),
    });
  }

  static String generateEnumCode(String enumName) {
    String source = File("properties/templates/enum_property.tmpl").readAsStringSync();

    var template = Template(source, htmlEscapeValues: false);
    return template.renderString({
      'enumName': enumName,
    });
  }
}
