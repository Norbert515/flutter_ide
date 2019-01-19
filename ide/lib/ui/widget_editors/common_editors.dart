import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/ui/home_page.dart';


mixin EditorMixin {

  String get id;

  void sendUpdate(String propertyName, Property property) {
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
    return Column(
      children: <Widget>[
        Text("Container Editor"),
        Text("Width"),
        TextField(controller: widthController,),
        Text("Height"),
        TextField(controller: heightController),
        RaisedButton(
          onPressed: () {
            print("Submitted");
            sendUpdate("color", ColorProperty(color: Color(0xffff0000)));
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
}
