import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/client/client.dart';
import 'package:ide/ui/widget_editors/property_changers/property_editor.dart';
import 'package:ide/ui/widgets/value_changers/color_changer.dart';
import 'package:ide/ui/widgets/value_changers/constraints_changer.dart';
import 'package:ide/ui/widgets/value_changers/double_changer.dart';
import 'package:ide/ui/widgets/value_changers/edge_insets_changer.dart';
import 'package:ide/ui/widgets/value_changers/enum_changer.dart';
import 'package:ide/ui/widgets/value_changers/string_changer.dart';
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

    // TODO use a registry so each changer registers itself
    PropertyType type = property.type;
    switch(type) {
      case PropertyType.alignment:
        return AlignmentChanger(
          key: ObjectKey(id),
          id: id,
          propertyName: key,
          value: property.data,
        );
      case PropertyType.double:
        return ChangeableDouble(
          key: ObjectKey(id),
          id: id,
          propertyKey: key,
          value: property.data,
        );
      case PropertyType.boxConstraints:
        return ChangeableConstraints(
          key: ObjectKey(id),
          id: id,
          value: property.data,
          propertyKey: key,
        );
      case PropertyType.color:
        return ColorChanger(
          key: ObjectKey(id),
          id: id,
          value: property.data,
          propertyKey: key,
        );
      case PropertyType.edgeInserts:
        return ChangeableEdgeInsets(
          key: ObjectKey(id),
          id: id,
          value: property.data,
          propertyKey: key,
        );
      case PropertyType.crossAxisAlignment:
        return EnumChanger(
          key: ObjectKey(id),
          id: id,
          propertyKey: key,
          enumProperty: property,
        );

      case PropertyType.mainAxisAlignment:
        return EnumChanger(
          key: ObjectKey(id),
          id: id,
          propertyKey: key,
          enumProperty: property,
        );
      case PropertyType.string:
        return StringChanger(
          key: ObjectKey(id),
          id: id,
          propertyKey: key,
          value: property.data,
        );
      case PropertyType.unknown:
        return Text("Unknown");
    }

    throw AssertionError("not handled it all");

  }
}