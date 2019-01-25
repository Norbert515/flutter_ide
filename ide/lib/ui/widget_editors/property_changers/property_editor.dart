import 'package:flutter/material.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:provider/provider.dart';




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
        ]..addAll(properties.map((entry) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.baseline,
              //textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(entry.key, style: IDETheme.of(context).propertyChangerTheme.propertyContainer,),
                SizedBox(width: 8,),
                Expanded(child: entry.value,),
              ],
            ),
          );
        }).toList()),
      ),
    );
  }


}
