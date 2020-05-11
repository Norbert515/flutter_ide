import 'package:widget_maker_2_0/data/widget_elements/base/literal_widget.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/AppBar.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Card.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Center.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Column.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/FloatingActionButton.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Icon.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/MaterialButton.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Row.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Scaffold.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Text.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/aaimporter.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:widget_maker_2_0/data/properties/meta_properties.dart';

Uuid _uuid = Uuid();

String get _i => _uuid.v1();

WidgetBoard syntaxText() {
  WidgetBoard b = WidgetBoard();

  var s = ScaffoldElement(id: _i);
  b.rootWidgetElement.tAccept(b, s);

  var a = AppBarElement(id: _i);
  s.tAccept(b, a, ScaffoldElement.APPBAR);

  /*

  b.rootWidgetElement.tAccept(b,
    child: ScaffoldElement(id: _i)
      ..tAccept(b,
        child: AppBarElement(id: _i)
          ..tAccept(b,
            child: TextElement(id: _i, text: "My App"),
          ),
        data: ScaffoldElement.APPBAR_KEY
      )
      ..tAccept(b,
        child: CenterElement(
          id: _i
        )..tAccept(b,
          child: TextElement(
            id: _i,
            text: "Hello World"
          ),
        ),
        data: ScaffoldElement.BODY_KEY
      )
      ..tAccept(b,
        child: FloatingActionButtonElement(id: _i)
          ..tAccept(b, child: IconElement(id: _i)),
        data: ScaffoldElement.FAB_KEY
      )
  );*/
  return b;
}

WidgetBoard getHelloWorldWidgetBoard() {
  var uuid = Uuid();
  WidgetBoard board = WidgetBoard();

  // TODO remove this later on when this is added by default
  var literalWidgetElement = LiteralWidgetElement(id: uuid.v1(), name: "Hello World Page");

  board.acceptNewChild(board.rootKey, literalWidgetElement);

  var scaffold = ScaffoldElement(
    id: uuid.v1(),
  );

  board.acceptNewChild(literalWidgetElement.id, scaffold);

  var appBar = AppBarElement(
    id: uuid.v1(),
  );

  var title = TextElement(
    id: uuid.v1(),
    data: "My App",
  );

  board.acceptNewChild(scaffold.id, appBar, SlotData(slotName: ScaffoldElement.APPBAR));
  board.acceptNewChild(appBar.id, title, SlotData(slotName: AppBarElement.TITLE));

  var bodyCenter = CenterElement(
    id: uuid.v1(),
  );

  var text = TextElement(id: uuid.v1(), data: "Hello World!");

  board.acceptNewChild(scaffold.id, bodyCenter, SlotData(slotName: ScaffoldElement.BODY));
  board.acceptNewChild(bodyCenter.id, text);

  var fab = FloatingActionButtonElement(
    id: uuid.v1(),
  );
  var icon = IconElement(id: uuid.v1(), icon: Icons.add);

  board.acceptNewChild(scaffold.id, fab, SlotData(slotName: ScaffoldElement.FLOATINGACTIONBUTTON));
  board.acceptNewChild(fab.id, icon);

  return board;
}

WidgetBoard getCardWidgetBoard() {
  var uuid = Uuid();
  WidgetBoard board = WidgetBoard();

  // TODO remove this later on when this is added by default
  var literalWidgetElement = LiteralWidgetElement(id: uuid.v1(), name: "Card Example");

  board.acceptNewChild(board.rootKey, literalWidgetElement);

  var size = WContainerElement(id: uuid.v1(), width: 344, height: 382, color: Colors.transparent);

  board.acceptNewChild(literalWidgetElement.id, size);

  var card = CardElement(
    id: uuid.v1(),
  );
  board.acceptNewChild(size.id, card);

  var column = ColumnElement(
    id: uuid.v1(),
  );
  board.acceptNewChild(card.id, column);

  var topSize = WContainerElement(id: uuid.v1(), height: 72, color: Colors.white);
  board.acceptNewChild(column.id, topSize, SlotData(slotName: "children"));

  var topRow = RowElement(
    id: uuid.v1(),
    crossAxisAlignment: CrossAxisAlignment.center,
  );
  board.acceptNewChild(topSize.id, topRow);

  var topImagePad =
      WContainerElement(id: uuid.v1(), color: Colors.transparent, padding: const EdgeInsets.symmetric(horizontal: 16));
  board.acceptNewChild(topRow.id, topImagePad, SlotData(slotName: "children"));

  var profileImage = WCircleAvatarElement(
    id: uuid.v1(),
    radius: 20,
    imageUrl:
        "https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=630&q=80",
  );
  board.acceptNewChild(topImagePad.id, profileImage);

  var titleColumn = ColumnElement(
    id: uuid.v1(),
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
  );
  board.acceptNewChild(topRow.id, titleColumn, SlotData(slotName: "children"));

  var title = TextElement(
    id: uuid.v1(),
    data: "Title goes here",
    style: TextStyle(color: Colors.black, fontSize: 20),
  );
  board.acceptNewChild(titleColumn.id, title, SlotData(slotName: "children"));

  var subTitle = TextElement(
    id: uuid.v1(),
    data: "Secondary Text",
    style: TextStyle(color: Colors.black, fontSize: 14),
  );
  board.acceptNewChild(titleColumn.id, subTitle, SlotData(slotName: "children"));

  var bigImage = WNetworkImageElement(id: uuid.v1(), height: 194, width: 344, fit: BoxFit.cover);
  board.acceptNewChild(column.id, bigImage, SlotData(slotName: "children"));

  var bottomPadding = WContainerElement(
    id: uuid.v1(),
    color: Colors.white,
    padding: EdgeInsets.only(
      top: 16,
      bottom: 8,
      right: 8,
      left: 8,
    ),
  );

  board.acceptNewChild(column.id, bottomPadding, SlotData(slotName: "children"));

  var bColumn = ColumnElement(
    id: uuid.v1(),
    mainAxisSize: MainAxisSize.min,
  );

  board.acceptNewChild(bottomPadding.id, bColumn);

  var bottomText = TextElement(
      id: uuid.v1(),
      style: TextStyle(color: Colors.black, fontSize: 14),
      data: "Lorem ipsum dolor sit amet, consectetur adisicing elit, sed do eisumo tempor");

  board.acceptNewChild(bColumn.id, bottomText, SlotData(slotName: "children"));

  var spacing = WContainerElement(
    id: uuid.v1(),
    height: 4,
    color: Colors.white,
  );
  board.acceptNewChild(bColumn.id, spacing, SlotData(slotName: "children"));

  var actionRow = RowElement(
    id: uuid.v1(),
  );

  board.acceptNewChild(bColumn.id, actionRow, SlotData(slotName: "children"));

  var b1 = MaterialButtonElement(id: uuid.v1(), padding: EdgeInsets.only(right: 8));
  board.acceptNewChild(actionRow.id, b1, SlotData(slotName: "children"));

  var b1Text = TextElement(
    id: uuid.v1(),
    data: "Action 1",
    style: TextStyle(color: Colors.purple),
  );
  board.acceptNewChild(b1.id, b1Text);

  var b2 = MaterialButtonElement(
    id: uuid.v1(),
  );
  board.acceptNewChild(actionRow.id, b2, SlotData(slotName: "children"));

  var b2Text = TextElement(
    id: uuid.v1(),
    data: "Action 2",
    style: TextStyle(color: Colors.purple),
  );
  board.acceptNewChild(b2.id, b2Text);

  return board;
}

WidgetBoard getPixelWidgetBoard() {
  var board = WidgetBoard();

  Uuid uuid = Uuid();
  // TODO remove this later on when this is added by default
  var literalWidgetElement = LiteralWidgetElement(id: uuid.v1(), name: "Pixel");
  board.acceptNewChild(board.rootKey, literalWidgetElement);

  return board;
}

WidgetBoard getDesktopWidgetBoard() {
  var board = WidgetBoard(
    canvasSize: const CanvasSize(width: 1440, height: 1024),
  );

  Uuid uuid = Uuid();
  // TODO remove this later on when this is added by default
  var literalWidgetElement = LiteralWidgetElement(id: uuid.v1(), name: "Desktop");
  board.acceptNewChild(board.rootKey, literalWidgetElement);

  return board;
}
