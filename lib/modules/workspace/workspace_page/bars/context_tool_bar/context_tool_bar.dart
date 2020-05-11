import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/modules/theme.dart';
import 'package:widget_maker_2_0/modules/workspace/interactors/context_tool_bar_interactor.dart';
import 'package:widget_maker_2_0/widgets/custom_stream_builder.dart';

import 'board_tool_bar.dart';
import 'literal_widget_tool_bar.dart';

class ContextToolBar extends StatefulWidget {

  @override
  _ContextToolBarState createState() => _ContextToolBarState();
}

class _ContextToolBarState extends State<ContextToolBar> {


  ContextToolbarInteractor contextToolbarInteractor;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contextToolbarInteractor = ContextToolbarInteractor(AppScope.of(context).widgetBoard);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: MyTheme.of(context).background2dp,
      child: PowerStreamBuilder<CurrentSelectionContext>(
        stream: contextToolbarInteractor.currentSelectionContext,
        initialData: CurrentSelectionContext.widgetBoard,
        builder: (context, snapshot) {
          switch(snapshot.requireData) {
            case CurrentSelectionContext.widgetBoard:
              return BoardToolBar();
            case CurrentSelectionContext.canvas:
              return Container(
                //color: Colors.blue,
              );
            case CurrentSelectionContext.widgetElement:
              return Container(
                //color: Colors.green,
              );
            case CurrentSelectionContext.literalRootWidget:
              return LiteralWidgetToolbar();
          }
          // Linter, let me alone please I checked every possible case!
          return null;
        },
      ),
    );
  }
}
