import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';

VisualWidget testWidget = VisualWrapper(
  className: "Container",
  sourceCode: 'Container(color: Colors.green,width: 50,height: 100,)',
  child: Container(
    color: Colors.green,
    width: 50,
    height: 100,
  ),
);

VisualWidget testWidget2 = VisualFloatingActionButton(
  backgroundColor: Colors.red,
  onPressed: (){},
);

VisualWidget testWidget3 = VisualWrapper(child: Icon(Icons.add), className: "Icon", sourceCode: "Icon(Icons.add)",);


