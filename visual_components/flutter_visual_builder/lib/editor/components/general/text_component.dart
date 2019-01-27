import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';


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
    return Text(getValue('text'));
  }

  @override
  // TODO implement
  Map<String, WidgetProperty> get modifiedWidgetProperties => {};

  @override
  // TODO implement
  Map<String, Property> initRemoteValues() => {
    'text': StringProperty(widget.text),
  };
}