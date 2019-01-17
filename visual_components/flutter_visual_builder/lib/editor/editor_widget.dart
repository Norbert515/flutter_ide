import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/material_components.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/dynamic_widget.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:grpc/grpc.dart';
import 'package:visual_server/src/server/visual_server.dart';

class VisualEditor extends StatefulWidget {



  @override
  VisualEditorState createState() {
    return new VisualEditorState();
  }
}

class VisualEditorState extends State<VisualEditor> {



  @override
  void initState() {
    super.initState();
    initServer();
  }


  Future initServer() async {
    final server = new Server([ServerService()]);
    await server.serve(port: 50051);
    print('Server listening on port ${server.port}...');

  }


  // TODO, the editor should be able to simulate the same widgets in different
  // settings. Because of that we need to have a way to draw the same widget
  // (with the same state and same global keys etc.) multiple times.
  //
  // This is somewhat a difficult problem. Will probably have to create a custom
  // element which lays out the same widget multiple times and draws it multiple
  // times.
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
            UnknownProperty(
              name: "onPressed",
              sourceCode: '(){\nprint("Hey!");\n}'
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