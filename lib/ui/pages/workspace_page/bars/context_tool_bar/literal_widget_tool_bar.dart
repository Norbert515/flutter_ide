import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/literal_widget.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/bars/context_tool_bar/dialogs/new_canvas_dialog.dart';

class LiteralWidgetToolbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              String selectedId = AppScope.of(context).widgetBoard.currentlySelectedValue;
              LiteralWidgetElement literalWidgetElement = AppScope
                  .of(context).widgetBoard.getWidgetElement(selectedId)
              as LiteralWidgetElement;
              AppScope.of(context).widgetBoard.makeInstanceable(literalWidgetElement.id);
            },
            child: Text("Make instancable"),
          ),
        ],
      ),
    );
  }
}