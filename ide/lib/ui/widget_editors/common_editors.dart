import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart' as prop;
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/home_page.dart';
import 'package:ide/ui/widgets/value_changers/numeric_values.dart';
import 'package:provider/provider.dart';


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

class ContainerEditor extends StatelessWidget with EditorMixin{

  ContainerEditor({Key key, this.id}) : super(key: key);

  final String id;

  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Provider.of<IDETheme>(context).lightBackground,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Container Editor", style: IDETheme.of(context).propertyChangerTheme.widgetName),
          Text("Id: $id", style: IDETheme.of(context).propertyChangerTheme.widgetId,),
          Divider(),
          ChangeableSize(
            id: id,
            widthKey: "width",
            heightKey: "height",
          ),
        ],
      ),
    );
  }
}
