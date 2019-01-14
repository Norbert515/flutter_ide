import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';
import 'package:flutter_visual_builder/dynamic_widget.dart';

class VisualEditor extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DragTarget<VisualWidget>(
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
    );
  }
}


class RootDraggable extends StatelessWidget {

  const RootDraggable({Key key, this.widgetAndSourceCode}) : super(key: key);

  final VisualWidget widgetAndSourceCode;


  @override
  Widget build(BuildContext context) {
    return Draggable<VisualWidget>(
      childWhenDragging: widgetAndSourceCode,
      data: widgetAndSourceCode,
      feedback: widgetAndSourceCode,
      child: widgetAndSourceCode,
      onDragStarted: () {
        print("Started inital drag with id ${widgetAndSourceCode.id}");
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