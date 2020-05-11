import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/ui/board_widget.dart';

class Trash extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: DragTarget<String>(
        onWillAccept: (_) => true,
        onAccept: (it) {
          AppScope.of(context).widgetBoard.removeWidget(it);
        },
        builder: (context, accepted, _) {
          if(accepted.isNotEmpty) {
            return Icon(Icons.delete, color: Colors.red);
          } else {
            return Icon(Icons.delete);
          }
        },
      ),
    );
  }
}
