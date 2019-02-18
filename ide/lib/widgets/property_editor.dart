import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/properties/converter.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/business_logic/client/client.dart';
import 'package:ide/business_logic/property_bloc.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/widgets/value_changers/alignment_changer.dart';
import 'package:ide/widgets/value_changers/bool_changer.dart';
import 'package:ide/widgets/value_changers/color_changer.dart';
import 'package:ide/widgets/value_changers/constraints_changer.dart';
import 'package:ide/widgets/value_changers/double_changer.dart';
import 'package:ide/widgets/value_changers/edge_insets_changer.dart';
import 'package:ide/widgets/value_changers/enum_changer.dart';
import 'package:ide/widgets/value_changers/int_changer.dart';
import 'package:ide/widgets/value_changers/string_changer.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart' as prop;
import 'package:flutter_visual_builder/business_logic/server/generated/server.pb.dart';
import 'value_changers/value_changer.dart';


class PropertySettingSection extends StatelessWidget {

  const PropertySettingSection({Key key}) : super(key: key);

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

    /*
    ValueWidget valueChanger = ValueWidget(
      id: id,
      valueChanger: StringWithConfirmChanger(
        value: property.data,
        onChange: (it) => {},
      ),
    );*/


    // TODO maybe use a registry so each changer registers itself
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
      case PropertyType.int:
        return IntChanger(
          key: ObjectKey(id),
          id: id,
          propertyKey:key,
          value: property.data
        );
      case PropertyType.unknown:
        return Text("Unknown");
    }

    throw AssertionError("not handled it all");
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 400,
      height: double.infinity,
      child: StreamBuilder<Widget>(
        stream: Provider.of<PropertyBloc>(context).editor.map(_convertToEditor),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            if(snapshot.error is Error) {
              Error error = snapshot.error;
              print("Error $error \n ${error.stackTrace}");
            }
            print("Error ${snapshot.error}");
          }
          if(!snapshot.hasData) {
            return Material(
              color: IDETheme
                        .of(context)
                        .lightBackground,
              child: Center(
                  child: Text("Select something", style: IDETheme.of(context).propertyChangerTheme.propertyContainer,)
              ),
            );
          }

          return Material(
            child: snapshot.requireData,
          );
        },
      ),
    );
  }
}

mixin EditorMixin {

  String get id;


  void sendUpdate(BuildContext context, String propertyName, prop.Property property) {
    Provider.of<VisualClient>(context).fieldUpdates.add(
        FieldUpdate()
          ..id = id
          ..propertyName = propertyName
          ..property = json.encode(property.toMap())
    );
  }
}


// TODO making an editor for a widget should be as easy
// as possible with as little boilerplate as possible.
// later this should be done fully automatically.
class PropertyEditor extends StatelessWidget {

  const PropertyEditor({Key key, this.widgetName, this.id, this.properties}) : super(key: key);

  final String widgetName;
  final String id;
  final List<MapEntry<String, Widget>> properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Provider.of<IDETheme>(context).lightBackground,
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widgetName, style: IDETheme.of(context).propertyChangerTheme.widgetName),
          Text("Id: $id", style: IDETheme.of(context).propertyChangerTheme.widgetId,),
          Divider(
            color: IDETheme.of(context).fontColor,
          ),
          Table(
            defaultColumnWidth: IntrinsicColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: _tableRows(context),
          ),
        ],
      ),
    );
  }
  List<TableRow> _tableRows(BuildContext context) {
    return properties.map((entry) {
      return TableRow(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(entry.key, style: IDETheme.of(context).propertyChangerTheme.propertyContainer),
          ),
          SizedBox(width: 16,),
          Padding(
            padding: const EdgeInsets.only(top : 20.0),
            child: Align(alignment: Alignment.topCenter,child: entry.value),
          ),
        ],
      );
    }).toList();
  }
}
