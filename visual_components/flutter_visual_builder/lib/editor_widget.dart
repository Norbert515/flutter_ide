import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';
import 'package:flutter_visual_builder/dynamic_widget.dart';

class VisualEditor extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DragTarget<VisualStatefulWidget>(
          builder: (context, it ,it2) {
            return Container(
                width: 200,
                height: double.infinity,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RootDraggable(buildingBlock: test2),
                    RootDraggable(buildingBlock: test3),
                    RootDraggable(buildingBlock: test4),
                    Expanded(child: RootDraggable(buildingBlock: test5)),
                  ],
                )
            );
          },
          onWillAccept: (it) => true,

        ),
        Expanded(child: AppWidget()),
      ],
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


class AppWidget extends StatelessWidget {


  final GlobalKey<VisualRootState> rootKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return VisualRoot(
      key: rootKey,
      child: VisualScaffold(
        id: "YOOOO",
        floatingActionButton: VisualFloatingActionButton(
          id: "BLUB",
          properties: [
            Property(
              name: "onPressed",
              value: '(){\nprint("Hey!");\n}'
            ),
          ],
            onPressed: (){
              print("Hey!");
            }
        ),
        body: VisualWrapper(
          id: "SOME ID",
          sourceCode: 'Center(child: RaisedButton(onPressed: ()'
              '{String source = rootKey.currentState.buildSourceCode();'
              'print("Here is the source: \n");print(source);}),),',
          child: Center(
            child: RaisedButton(onPressed: (){
              String source = rootKey.currentState.buildSourceCode();
              print("Here is the source: \n");
              print(source);
            }),
          ),
        ),
      ),
    );
  }




}