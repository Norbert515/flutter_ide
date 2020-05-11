import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/utils/utils.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';

class WidgetBoardFlatterner {

  // TODO there was a bug with dep injection, for now -- fix later to make clean injection
  WidgetBoard widgetBoard;



  /// Returns all widget elements in a list, therefore walking down the recursive tree
  ///
  /// This excludes children of widetElements which are collapsed
  /// TODO refactor when that property is moved to the canvas
  List<IndexedObject<WidgetElement>> getAllWidgetElementsFlat(String canvasId) {
    if(canvasId == null)
      return [];
    if (widgetBoard.allWidgets[canvasId] == null) return [];
    return _getAllWidgetElementsFlat(0, widgetBoard.allWidgets[canvasId].id, [], 0).toList();
  }

  Iterable<IndexedObject<WidgetElement>> _getAllWidgetElementsFlat(int index, String id, List<int> treePart, int largest) sync* {
    yield IndexedObject<WidgetElement>(
        index: index,
        object: widgetBoard.allWidgets[id],
        treePart: treePart
    );
    if(widgetBoard.allWidgets[id].isCollapsed) {
      return;
    }
    assert(widgetBoard.allWidgets[id] != null, "Coudln't find $id");
    int i = largest + 1;
    List<String> chil = widgetBoard.allWidgets[id].children.expand((it) => it.childrenIds).toList();
    for (String childId in chil){
      if (childId != null) {
        assert(widgetBoard.allWidgets[childId] != null, "\nThis (a ${widgetBoard.allWidgets[id].runtimeType}) has a non existen child with the following id: $childId\n");
        yield* _getAllWidgetElementsFlat(index + 1, childId, List.from(treePart)..add(i), largest + chil.length);
      }
      i ++;
    }
  }
}