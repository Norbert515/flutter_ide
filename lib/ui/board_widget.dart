import 'package:widget_maker_2_0/data/app_scope/code_sync/sync_client.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:provider/provider.dart';

class BoardWidget extends StatefulWidget {


  const BoardWidget({Key key, this.child}) : super(key: key);
  final Widget child;

/*
  static WidgetBoard of(BuildContext context, {bool listen = true}) {
    return Provider.of<WidgetBoard>(context, listen: listen);
  }

  static void overrideWidgetBoard(BuildContext context, WidgetBoard widgetBoard) {
    _BoardWidgetState state = context.ancestorStateOfType(TypeMatcher<_BoardWidgetState>());
    state._override(widgetBoard);
  }*/

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {

  WidgetBoard widgetBoard;
  SyncServer server;

  @override
  void initState() {
    super.initState();
    widgetBoard = WidgetBoard();

    server = SyncServer(_override);
    server.connect();
  }


  void _override(WidgetBoard newBoard) {
    setState(() {
      widgetBoard.dispose();
      widgetBoard = newBoard;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Provider<SyncServer>.value(
      value: server,
      child: Provider<WidgetBoard>.value(
        child: widget.child,
        value: widgetBoard,
      ),
    );
  }
}
