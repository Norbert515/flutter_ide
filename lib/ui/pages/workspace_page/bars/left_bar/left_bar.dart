import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/interactors/board_interactor.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/bars/left_bar/widget_tree.dart';
import 'package:widget_maker_2_0/ui/theme.dart';

class LeftBar extends StatelessWidget {


  final VoidCallback onNewWidget;
  final VoidCallback onTemplate;

  const LeftBar({Key key, this.onNewWidget, this.onTemplate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.of(context).background4dp,
      width: 300,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(child: WidgetTree()),
          RaisedButton(
              child: Text("New Widget (or ctrl+space)"),
              onPressed: onNewWidget,
          ),
        ],
      ),
    );
  }
}
