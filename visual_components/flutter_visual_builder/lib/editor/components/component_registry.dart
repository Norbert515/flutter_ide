
import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/general/text_component.dart';
import 'package:flutter_visual_builder/editor/components/input/raised_button.dart';
import 'package:flutter_visual_builder/editor/components/layout/center.dart';
import 'package:flutter_visual_builder/editor/components/layout/container_component.dart';
import 'package:flutter_visual_builder/editor/components/layout/list_components.dart';
import 'package:flutter_visual_builder/editor/components/material/app_bar_component.dart';
import 'package:flutter_visual_builder/editor/components/material_components.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette_items.dart';
import 'package:uuid/uuid.dart';

/// Register each component which should be available to drop in
/// in this class
class ComponentRegistry {

  var uuid = new Uuid();

  List<Widget> getGeneral() {
    return _getGeneral().map((it) => RootDraggable(buildingBlock: it,)).toList();
  }

  List<BuildingBlock> _getGeneral() {
    return [
      BuildingBlock(
          visualWidget: () => VisualFloatingActionButton(
            id: uuid.v1(),
            backgroundColor: Colors.red,
            onPressed: (){},
          ),
          representation: PaletteItem(
            icon: Icon(Icons.radio_button_unchecked),
            name: "Floating Action Button",
          )
      ),
      BuildingBlock(
        visualWidget: () => VisualWrapper(
          id: uuid.v1(),
          child: Icon(Icons.add),
          sourceCode: 'Icon(Icons.add)',
        ),
        representation: PaletteItem(
          icon: Icon(Icons.add),
          name: "Icon",
        ),
      ),
      BuildingBlock(
        visualWidget: () => VisualContainer(
          color: Colors.green,
          id: uuid.v1(),
        ),
        representation: PaletteItem(
          icon: Icon(Icons.check_box_outline_blank),
          name: "Container",
        ),
      ),
      BuildingBlock(
        visualWidget: () => VisualColumn(
          id: uuid.v1(),
          mainAxisSize: MainAxisSize.min,
        ),
        representation: PaletteItem(
          icon: Icon(Icons.format_list_bulleted),
          name: "Column",
        ),
      ),
      BuildingBlock(
        visualWidget: () => TextComponent(
          id: uuid.v1(),
          text: "...",
        ),
        representation: PaletteItem(
          icon: Icon(Icons.text_fields),
          name: "Text",
        ),
      ),
      BuildingBlock(
        visualWidget: () => AppBarComponent(
          id: uuid.v1(),
          backgroundColor: Colors.yellow,
          elevation: 4,
        ),
        representation: PaletteItem(
          icon: Icon(Icons.signal_wifi_4_bar),
          name: "App Bar",
        ),
      ),
      BuildingBlock(
        visualWidget: () => RaisedButtonComponent(
          id: uuid.v1(),
        ),
        representation: PaletteItem(
          icon: Icon(Icons.crop_16_9),
          name: "Raised Button",
        ),
      ),
      BuildingBlock(
        visualWidget: () => CenterComponent(
          id: uuid.v1(),
        ),
        representation: PaletteItem(
          icon: Icon(Icons.center_focus_weak),
          name: "Center",
        ),
      ),
    ];
  }
}

typedef VisualWidgetBuilder = VisualStatefulWidget Function();

class BuildingBlock {


  BuildingBlock({this.visualWidget, this.representation});

  final VisualWidgetBuilder visualWidget;
  final Widget representation;


}

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