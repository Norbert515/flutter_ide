import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/component_registry.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette_items.dart';
import 'package:ide/themeing/ide_theme.dart';

class WidgetPalette extends StatelessWidget {

  final ComponentRegistry componentRegistry = ComponentRegistry();

  @override
  Widget build(BuildContext context) {
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
  }
}

class RootDraggable extends StatefulWidget {
  const RootDraggable({Key key, this.buildingBlock}) : super(key: key);

  final BuildingBlock buildingBlock;

  @override
  RootDraggableState createState() {
    return new RootDraggableState();
  }
}

class RootDraggableState extends State<RootDraggable> {
  @override
  Widget build(BuildContext context) {
    return Draggable<VisualStatefulWidget>(
      childWhenDragging: widget.buildingBlock.representation,
      data: widget.buildingBlock.visualWidget(),
      feedback: widget.buildingBlock.representation,
      child: widget.buildingBlock.representation,
      onDragStarted: () {
        // TODO this is so a new id is generated each drag, this should be cleaned
        // up at some point
        setState((){});
        // TODO find a better solution of generating new ids
        //print("Started inital drag with id ${buildingBlock.visualWidget.id}");
      },
    );
  }
}
