

import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/dynamic_widget.dart';
import 'package:flutter_visual_builder/editor/editor_widget.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette_items.dart';

class WidgetPalette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: 200,
          height: double.infinity,
          alignment: Alignment.center,
          color: Color(0xff313131),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PaletteCategory(
                title: "Layout",
              ),

              RootDraggable(buildingBlock: test2),
              RootDraggable(buildingBlock: test3),
              RootDraggable(buildingBlock: test4),
              RootDraggable(buildingBlock: test5),
            ],
          )
      ),
    );
  }
}


class RootDraggable extends StatelessWidget {

  const RootDraggable({Key key, this.buildingBlock}) : super(key: key);

  final BuildingBlock buildingBlock;


  @override
  Widget build(BuildContext context) {
    return Draggable<VisualStatefulWidget>(
      childWhenDragging: buildingBlock.representation,
      data: buildingBlock.visualWidget,
      feedback: buildingBlock.representation,
      child: buildingBlock.representation,
      onDragStarted: () {
        print("Started inital drag with id ${buildingBlock.visualWidget.id}");
      },
    );
  }
}