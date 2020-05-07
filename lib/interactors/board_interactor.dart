
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/app_scope/currently_dragging.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/bars/palette/palette_bar.dart';
import 'package:widget_maker_2_0/ui/widgets/dialogs/delete_or_merge_dialog.dart';
import 'package:widget_maker_2_0/ui/utils/at_cursor_alert.dart';
import 'package:widget_maker_2_0/ui/utils/global_draggable.dart';

/// Intermediate class to pull out code from the widget
///
/// This is going to be renamed/ removed/ moved at some point in the future
///

class BoardInteractor {


  // TODO make this an inherited widget or something?
  static BoardInteractor _instance;

  BoardInteractor._();

  factory BoardInteractor() {
    if(_instance == null)
      _instance = BoardInteractor._();
    return _instance;
  }

  void insertPaletteItem(BuildContext context, PaletteItem element) async {
    if(element != null) {
      var widgetElement = element.widgetElement;
      AppScope.of(context).widgetBoard.addChild(widgetElement);
      Provider.of<CurrentlyDraggingState>(context).setDragging(true);
      bool accepted = await startGlobalDrag<String>(context,
          data: widgetElement.id,
          feedback: PaletteItemVisualFeedback(
            paletteItem: element,
          )

      );
      if(!accepted) {
        AppScope.of(context).widgetBoard.removeChild(widgetElement.id);
        showDidNotAccept(context);
      }
    }
    Provider.of<CurrentlyDraggingState>(context).setDragging(false);

  }


  void delete(BuildContext context) async {
    var widgetBoard = AppScope.of(context).widgetBoard;
    String id = widgetBoard.currentlySelectedValue;
    if(id == null) return;

    if(!widgetBoard.hasChildren(id)) {
      widgetBoard.removeWidget(id);
      return;
    }

    if(widgetBoard.canMerge(id)) {
      var operation = await showDeleteOperationDialog(context);
      if (operation != null) {
        if (operation == DeleteOperation.deleteSubtree) {
          widgetBoard.removeWidget(id);
        } else if (operation == DeleteOperation.replaceWithChild) {
          widgetBoard.replaceWithChildren(id);
        }
      }
    } else {
      widgetBoard.removeWidget(id);
    }
  }

}