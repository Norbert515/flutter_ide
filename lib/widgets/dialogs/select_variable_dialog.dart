import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/properties/basic_properties.dart';

class SelectVariableDialog extends StatelessWidget {

  const SelectVariableDialog({Key key, this.properties}) : super(key: key);

  final List<MProperty> properties;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: ListView(
          children: properties.map((it) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop(it);
              },
              child: Text("${it.runtimeType} ${it.name}"),
            );
          }).toList()
        ),
      ),
    );
  }
}
