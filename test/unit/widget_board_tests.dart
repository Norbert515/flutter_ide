import 'package:flutter_test/flutter_test.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/properties/meta_properties.dart';
import 'package:widget_maker_2_0/widget_elements/base/meta.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/aaimporter.dart';

void main() {
  test('Widget boards smoke tests', () async {
    var board = WidgetBoard(canvasSize: CanvasSize(width: 100, height: 100));
    assert(board.rootWidgetElement is CanvasElement);
    assert(board.rootWidgetElement.isRoot);
    assert((board.rootWidgetElement as CanvasElement).canvasSize.value == CanvasSize(width: 100, height: 100));
  });


  test('Widgetboard add element', () async {
    var board = WidgetBoard();
    var container = WContainerElement(
      id: "3"
    );
    board.acceptNewChild(board.rootWidgetElement.id, container);

    assert(board.getWidgetElement("3") == container);
    assert(board.getRootElement().children.length == 1);
    assert(board.getRootElement().children.first.isSingleChild);
    assert(board.getRootElement().children.first.childrenIds.length == 1);
    assert(board.getRootElement().children.first.childrenIds.first == "3");
  });

  test('WidgetBoard wrap child', () async {
    var board = WidgetBoard();
    var container = WContainerElement(
      id: "container"
    );

    board.acceptNewChild(board.rootWidgetElement.id, container);

    var center = CenterElement(
      id: "center"
    );

    board.wrap(container.id, center);

    assert(board.getWidgetElement("center") != null);
    assert(board.getWidgetElement("container") != null);
    assert(center.children.first.childrenIds.first == "container");

    var padding = PaddingElement(
      id: "padding"
    );

    board.wrap(center.id, padding);

    assert(padding.children.first.childrenIds.first == "center");


  });

  test('WidgetBoard wrap with list', () async {
    var board = WidgetBoard();
    var container = WContainerElement(
      id: '3'
    );

    board.acceptNewChild(board.getRootElement().id, container);

    var row = RowElement(
      id: "row"
    );
    board.wrap(container.id, row);

    assert(board.getWidgetElement(row.id) != null);
    assert(row.children.first.slotName == "children");
    assert(row.children.first.childrenIds.first == container.id);

    var column = ColumnElement(
      id: "colum"
    );

    board.wrap(row.id, column);

    assert(board.getWidgetElement(column.id) != null);
    assert(column.children.first.childrenIds.first == "row");
    // Pretty big chain, be essentially - check if the grandchild for the column is the container
    assert(board.getWidgetElement(column.children.first.childrenIds.first).children.first.childrenIds.first == container.id);
  });


  test('WidgetBoard list insertion test', () async {
    var board = WidgetBoard();
    var row = RowElement(
      id: "row"
    );

    board.acceptNewChild(board.getRootElement().id, row);

    var container = WContainerElement(
      id: "container"
    );
    board.acceptNewChild(row.id, container);

    assert(row.children.first.childrenIds.first == container.id);

    var container2 = WContainerElement(
      id: 'container2'
    );
    board.acceptNewChild(row.id, container2);

    assert(row.children.first.childrenIds.first == container.id);
    assert(row.children.first.childrenIds[1] == container2.id);

    var container3 = WContainerElement(
      id: 'container3'
    );

    board.acceptNewChild(row.id, container3, SlotData(
      slotName: "children",
      data: 0
    ));


    expect(row.children.first.childrenIds.first, container3.id);
    expect(row.children.first.childrenIds[1], container.id);
    expect(row.children.first.childrenIds[2], container2.id);

  });


  test('WidgetBoard wrap icon in appBar', () async {
    var board = WidgetBoard();
    var icon = IconElement(
      id: "dasd"
    );

    board.acceptNewChild(board.rootWidgetElement.id, icon);

    var appBar = AppBarElement(
      id: "AppBar"
    );

    board.wrap(icon.id, appBar);


    expect(appBar.children[0].childrenIds.first, icon.id);
  });
}