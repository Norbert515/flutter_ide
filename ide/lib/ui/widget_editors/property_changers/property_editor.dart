import 'package:flutter/material.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart' as prop;
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/ui/home_page.dart';

mixin EditorMixin {

  String get id;


  void sendUpdate(String propertyName, prop.Property property) {
    serverClient.fieldUpdates.add(
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
          Divider(),
          /*Expanded(
            child: Column(
              children: _oneLiners(context),
            ),
          ),*/
          Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getIdentifiers(context),
              ),
              SizedBox(width: 4,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getValueChangers(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _oneLiners(BuildContext context) {
    return properties.map((entry) {
      return Row(
        children: <Widget>[
          Text(entry.key, style: IDETheme.of(context).propertyChangerTheme.propertyContainer),
          Spacer(),
          entry.value,
          Spacer(),
        ],
      );
    }).toList();
  }

  List<Widget> _getIdentifiers(BuildContext context) {
    return properties.map((entry) {
      return SizedBox(height:70,child: Center(child: Text(entry.key, style: IDETheme.of(context).propertyChangerTheme.propertyContainer)));
    }).toList();

  }

  List<Widget> _getValueChangers(BuildContext context) {
    return properties.map((entry) {
      return SizedBox(height:70,child: entry.value);
    }).toList();
  }

}
