import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/widget_elements/base/literal_widget.dart';
import 'package:widget_maker_2_0/widget_elements/base/meta.dart';

enum CurrentSelectionContext {
  // Nothing is selected so the top level widget board has focus
  widgetBoard,
  // A canvas is selected
  canvas,
  // A widget is selected
  widgetElement,
  // Literal root widget selected,
  literalRootWidget,
}

class ContextToolbarInteractor {

  ContextToolbarInteractor._(this.currentSelectionContext);

  factory ContextToolbarInteractor(WidgetBoard widgetBoard) {

    Stream<CurrentSelectionContext> currentSelectionContext = widgetBoard.currentlySelected.map((it) {
      if(it == null) {
        return CurrentSelectionContext.widgetBoard;
      } else {
        if(widgetBoard.getWidgetElement(it) is CanvasElement) {
          return CurrentSelectionContext.canvas;
        } else if(widgetBoard.getWidgetElement(it) is LiteralWidgetElement){
          return CurrentSelectionContext.literalRootWidget;
        } else {
          return CurrentSelectionContext.widgetElement;
        }
      }
    });

    return ContextToolbarInteractor._(currentSelectionContext);
  }


  final Stream<CurrentSelectionContext> currentSelectionContext;

}