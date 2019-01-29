import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/component_registry.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/editor_widget.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette_items.dart';
import 'package:ide/themeing/ide_theme.dart';

class WidgetPalette extends StatelessWidget {


  final ComponentRegistry componentRegistry = ComponentRegistry();


  @override
  Widget build(BuildContext context) {
    return DragTarget<VisualStatefulWidget>(
      onWillAccept: (_) => true,
      builder: (context, one, two) {
        return Material(
          child: Container(
              width: 200,
              height: double.infinity,
              alignment: Alignment.center,
              color: IDETheme.of(context).lightBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[]
                ..add(PaletteCategory(
                  title: "Layout",
                ))
                ..addAll(componentRegistry.getGeneral())
                ..add(PaletteCategory(
                  title: "Input",
                ))
                ..addAll([])
                ..add(PaletteCategory(
                  title: "Stuff",
                )),
              )),
        );
      },
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
