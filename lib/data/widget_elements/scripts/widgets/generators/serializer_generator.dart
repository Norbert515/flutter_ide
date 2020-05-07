import 'package:mustache/mustache.dart';
import 'package:widget_maker_2_0/data/widget_elements/scripts/properties/parser/models.dart';
import 'package:widget_maker_2_0/data/widget_elements/scripts/widgets/models.dart';
import 'dart:io';

class SerializerGenerator {

  static String generateSerializer(List<ParsedWidget> widgets, List<ObjectProp> props) {
    String source = File("widgets/templates/widget_serializer.tmpl").readAsStringSync();
    var template = Template(source, htmlEscapeValues: false);
    return template.renderString({
      'widgets': widgets.map((it) => it.toMap()).toList(),
      'props': props.indexedMap((it, index) => it.toMap()..['last'] = index == props.length - 1).toList(),
    });
  }


  static String finalGenerateConverter(List<ParsedWidget> widgets) {
    String source = File("widgets/templates/final_widget_converter.tmpl").readAsStringSync();
    var template = Template(source, htmlEscapeValues: false);
    return template.renderString({
      'widgets': widgets.map((it) => it.toMap()).toList(),
    });
  }
}

extension on List {

  Iterable<T> indexedMap<T>(T f(dynamic e, int index)) sync* {
    List me = this;
    for(int i = 0; i < this.length; i++) {
      yield f(me[i], i);
    }
  }
}