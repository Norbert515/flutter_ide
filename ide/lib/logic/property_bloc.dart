import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/client/client.dart';
import 'package:ide/ui/widget_editors/property_changers/property_editor.dart';
import 'package:ide/ui/widgets/value_changers/double_changer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_visual_builder/editor/properties/converter.dart';
import 'package:ide/ui/widgets/value_changers/alignment_changer.dart';

class PropertyBloc {


  PropertyBloc._({this.editor});


  factory PropertyBloc(VisualClient visualClient) {


    Observable<Widget> widgetStream = Observable(visualClient.serverClient.streamSelected(SelectStream())
        .map(_convertToEditor));

    return PropertyBloc._(
      editor: widgetStream,
    );
  }

  final Observable<Widget> editor;

  static Widget _convertToEditor(SelectedWidgetWithProperties it) {


    var widgets = it.properties.map((key, value) {
      var property = convertToProperty(value);
      return MapEntry(key, property);
    }).map((key, property) => MapEntry(key, _convertToPropertyChanger(it.id, key, property)))
    .entries.toList();

    return PropertyEditor(
      widgetName: it.type,
      properties: widgets,
      id: it.id,
    );
  }

  static Widget _convertToPropertyChanger(String id, String key, Property property) {

    PropertyType type = property.type;
    switch(type) {
      case PropertyType.alignment:
        return AlignmentChanger(
          id: id,
          propertyName: key,
          value: property.data,
        );
      case PropertyType.double:
        return ChangeableDouble(
          id: id,
          propertyKey: key,
          value: property.data,
        );
      case PropertyType.boxConstraints:
        return SizedBox();
      case PropertyType.color:
        return SizedBox();
      case PropertyType.edgeInserts:
        return SizedBox();
      case PropertyType.unknown:
        return Text("Unknown");
    }

    throw AssertionError("not handled it all");

  }
}