import 'dart:math';

import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/ui/board_widget.dart';
import 'package:widget_maker_2_0/ui/widgets/general/simple_2D_canvas.dart';
import 'dart:math' as math;

class DeselectWidget extends StatelessWidget {

  final Widget child;

  const DeselectWidget({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AppScope.of(context).widgetBoard.setSelected(null);
      },
      child: child,
    );
  }
}

class DefocusWidget extends StatelessWidget {

  final Widget child;

  const DefocusWidget({Key key, this.child}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}



class CanvasSpace extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder<void>(
          stream: AppScope.of(context).widgetBoard.onTopLevelChangeStream,
          builder: (context, _) {
           return Simple2DCanvas(
             widgets: AppScope.of(context).widgetBoard.canvases.map<String, CanvasWidget>((key, entry) {
               return MapEntry<String, CanvasWidget>(key, CanvasWidget(
                 child: entry.generateWidget(),
                 size: entry.canvasSize.value.size,
                 position: entry.position.value,
               ));
             }),
           );
          },
        ),
        PlayModeToggle(),
      ],
    );
    //return Center(child: FittedBox(child: Center(child: AppScope.of(context).widgetBoard.getRootElement().generateWidget())));
  }
}


class PlayModeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Build"),
          StreamBuilder<bool>(
              stream: AppScope.of(context).playModeStream,
              initialData: AppScope.of(context).playModeStream.value,
              builder: (context, snapshot) {
                return Switch(
                  value: snapshot.data,
                  onChanged: (it) {
                    AppScope.of(context).updatePlayMode(it);
                  },
                );
              }
          ),
          Text("Play"),
        ],
      ),
    );
  }
}
