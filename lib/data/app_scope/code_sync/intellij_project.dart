import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/app_scope/code_sync/sync_client.dart';
import 'package:widget_maker_2_0/modules/workspace/widget_board.dart';

class IntellijPusher extends StatefulWidget {

  final Widget child;

  static IntellijPusherState of(BuildContext context) {
    return Provider.of<IntellijPusherState>(context);
  }

  const IntellijPusher({Key key, this.child}) : super(key: key);
  @override
  IntellijPusherState createState() => IntellijPusherState();
}

class IntellijPusherState extends State<IntellijPusher> {


  WidgetBoard widgetBoard;
  String path;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newBoard = AppScope.of(context).widgetBoard;

    if(newBoard != widgetBoard) {
      widgetBoard = newBoard;
      /*widgetBoard.addListener(() {
        String code = widgetBoard.getLayoutCode();
        writeToFile(code);
      });*/
    }
  }


  void writeToFile(String code) async {

    Provider.of<SyncServer>(context).sendCode(code);
    /*
    if(path != null) {
      var file = File(path);
      if(await file.exists()) {
        await file.writeAsString(code);
      }
    }*/
  }
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: widget.child,
    );
  }
}
