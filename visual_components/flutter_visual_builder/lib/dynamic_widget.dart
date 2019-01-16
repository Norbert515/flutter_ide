import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/components/list_components.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';
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
  representation: BlockWidget("FAB")
);



BuildingBlock get test3 => BuildingBlock(
    visualWidget: VisualWrapper(
      id: uuid.v1(),
      child: Icon(Icons.add),
      sourceCode: 'Icon(Icons.add)',
    ),
    representation: Icon(Icons.add)
);

BuildingBlock get test4 => BuildingBlock(
    visualWidget: VisualContainer(
      color: Colors.green,
      id: uuid.v1(),
      height: 100,
      width: 100,
    ),
    representation: BlockWidget("Container")
);


BuildingBlock get test5 => BuildingBlock(
    visualWidget: VisualColumn(
      id: uuid.v1(),
      mainAxisSize: MainAxisSize.min,
    ),
    representation: BlockWidget("Column")
);




class BlockWidget extends StatelessWidget {

  const BlockWidget(this.text);

  final String text;


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(16),
        width: 100,
        height: 100,
        color: Colors.pink,
        child: Text(text),
      ),
    );
  }
}
