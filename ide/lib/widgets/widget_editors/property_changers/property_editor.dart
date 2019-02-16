import 'package:flutter/material.dart';
import 'package:ide/business_logic/client/client.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart' as prop;
import 'package:flutter_visual_builder/business_logic/server/generated/server.pb.dart';

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
    // TODO replace with table
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
