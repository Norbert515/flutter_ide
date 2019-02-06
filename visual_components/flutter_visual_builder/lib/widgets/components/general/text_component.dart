import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/utils/string_builder.dart';


class TextComponent extends VisualStatefulWidget {

  TextComponent({
    String id,
    Map<String, Property> properties,
    Map<String, WidgetProperty> widgetProperties,
    this.text,
  }) : super(id: id, key: GlobalKey<VisualState>(), properties: properties ?? const {}, widgetProperties: widgetProperties?? const {});


  final String text;

  @override
  _TextComponentState  createState() => _TextComponentState();

  @override
  String get originalClassName => "Text";
}

class _TextComponentState extends VisualState<TextComponent> {


  @override
  Widget buildWidget(BuildContext context) {
    return Text(getValue('text'), style: TextStyle(color: getValue('fontColor'), fontSize: getValue('fontSize')),);
  }

  @override
  void buildSourceCode(StringBuilder stringBuilder) {
    stringBuilder.writeNoIndent('${widget.originalClassName}("${remoteValues['text'].data}")');
  }



  @override
  // TODO implement
  Map<String, WidgetProperty> getWidgets() => {};

  @override
  // TODO implement
  Map<String, Property> initRemoteValues() => {
    'text': StringProperty(widget.text),
    'fontSize': DoubleProperty(data: 20),
    'fontColor': ColorProperty(color: Colors.black),
  };
}