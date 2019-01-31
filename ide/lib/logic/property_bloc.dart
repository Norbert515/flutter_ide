import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/client/client.dart';
import 'package:ide/ui/value_changers/alignment_changer.dart';
import 'package:ide/ui/value_changers/bool_changer.dart';
import 'package:ide/ui/value_changers/color_changer.dart';
import 'package:ide/ui/value_changers/constraints_changer.dart';
import 'package:ide/ui/value_changers/double_changer.dart';
import 'package:ide/ui/value_changers/edge_insets_changer.dart';
import 'package:ide/ui/value_changers/enum_changer.dart';
import 'package:ide/ui/value_changers/string_changer.dart';
import 'package:ide/ui/widget_editors/property_changers/property_editor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_visual_builder/editor/properties/converter.dart';

class PropertyBloc {

  // TODO implement receiving widget removed events
  PropertyBloc._({this.editor, this.removedIds});

  // TODO this shouldn't return a finished widget - instead a representation of
  // it so the widget layer can take care of constructing the actual widget.

  factory PropertyBloc(VisualClient visualClient) {

    PublishSubject<String> removedIds = PublishSubject();
    // TODO this is a mess. Please clean it up!

    Observable<Widget> widgetStream = Observable(visualClient.serverClient.streamSelected(SelectStream())
        .map(_convertToEditor)).asBroadcastStream();

    return PropertyBloc._(
      editor: widgetStream,
      removedIds: removedIds,
    );
  }

  final Observable<Widget> editor;

  final Sink<String> removedIds;

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
      case PropertyType.bool:
        return BoolChanger(
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