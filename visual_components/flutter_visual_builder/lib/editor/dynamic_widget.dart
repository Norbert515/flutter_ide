import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/general/text_component.dart';
import 'package:flutter_visual_builder/editor/components/layout/container_component.dart';
import 'package:flutter_visual_builder/editor/components/layout/list_components.dart';
import 'package:flutter_visual_builder/editor/components/material_components.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette_items.dart';
import 'package:uuid/uuid.dart';

var uuid = new Uuid();


class BuildingBlock {


  BuildingBlock({this.visualWidget, this.representation});

  final VisualStatefulWidget visualWidget;
  final Widget representation;


}




BuildingBlock get test2  => BuildingBlock(
  visualWidget: VisualFloatingActionButton(
    id: uuid.v1(),
    backgroundColor: Colors.red,
    onPressed: (){},
  ),
  representation: PaletteItem(
    icon: Icon(Icons.radio_button_unchecked),
    name: "Floating Action Button",
  )
);



BuildingBlock get test3 => BuildingBlock(
    visualWidget: VisualWrapper(
      id: uuid.v1(),
      child: Icon(Icons.add),
      sourceCode: 'Icon(Icons.add)',
    ),
    representation: PaletteItem(
      icon: Icon(Icons.add),
      name: "Icon",
    ),
);

BuildingBlock get test4 => BuildingBlock(
    visualWidget: VisualContainer(
      color: Colors.green,
      id: uuid.v1(),
      height: 100,
      width: 100,
    ),
    representation: PaletteItem(
      icon: Icon(Icons.check_box_outline_blank),
      name: "Container",
    ),
);


BuildingBlock get test5 => BuildingBlock(
    visualWidget: VisualColumn(
      id: uuid.v1(),
      mainAxisSize: MainAxisSize.min,
    ),
    representation: PaletteItem(
      icon: Icon(Icons.format_list_bulleted),
      name: "Column",
    ),
);

BuildingBlock get text => BuildingBlock(
  visualWidget: TextComponent(
    id: uuid.v1(),
    text: "...",
  ),
  representation: PaletteItem(
    icon: Icon(Icons.text_fields),
    name: "Text",
  ),
);



class BlockWidget extends StatelessWidget {

  const BlockWidget(this.text);

  final String text;


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        color: Colors.pink,
        child: Text(text),
      ),
    );
  }
}
