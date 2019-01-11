

import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/dynamic_widget.dart';
import 'package:flutter_visual_builder/main.dart';

class VisualEditor extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DragTarget<DynamicWidget>(
          builder: (context, it ,it2) {
            return Container(
                width: 200,
                height: double.infinity,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RootDraggable(widgetAndSourceCode: testWidget),
                    RootDraggable(widgetAndSourceCode: testWidget2),
                    RootDraggable(widgetAndSourceCode: testWidget3),
                  ],
                )
            );
          },
          onWillAccept: (it) => true,

        ),
        Expanded(child: AppWidget()),
      ],
    );  }
}
