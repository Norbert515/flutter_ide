import 'dart:io';
import 'package:mustache/mustache.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/widgets/models.dart';

class WidgetGenerator {


  static String generateWidgetElement(ParsedWidget widget) {
    String source = File("widgets/templates/widget_element.tmpl").readAsStringSync();
    var template = Template(source, htmlEscapeValues: false);
    return template.renderString(widget.toMap());
  }
}