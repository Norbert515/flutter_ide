import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/properties/meta_properties.dart';

import 'dialogs/new_canvas_dialog.dart';

/// A toolbar which is showing the context for the top level component
///
/// This toolbar shows options related to canvases.
/// This is visible when nothing else is selected.
class BoardToolBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              NewCanvasDialogResult canvas = await showDialogAndRestoreFocus<NewCanvasDialogResult>(context: context, builder: (context) => NewCanvasDialog());
              AppScope.of(context).widgetBoard.addCanvas(canvas?.name, canvas.canvasSize);
            },
            child: Text("New Canvas"),
          ),
        ],
      ),
    );
  }
}




