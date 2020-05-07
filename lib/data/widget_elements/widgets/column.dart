import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Column.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/list_helpers.dart';
import 'package:widget_maker_2_0/ui/utils/global_draggable.dart';

import 'base.dart';

class ColumnElementWidget extends StatefulWidget with ElementWidgetMixin {
  ColumnElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _ColumnElementWidgetState createState() => _ColumnElementWidgetState();
}

class _ColumnElementWidgetState extends State<ColumnElementWidget>
    with
        ElementWidgetStateMixin<ColumnElement, ColumnElementWidget>,
        ListElementWidgetStateMixin {


  Widget toAdd;
  int position;
  GlobalKey columnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (childrenIds.isEmpty) {
      return getArrow(Axis.vertical);
    }


    Widget row = Column(
        crossAxisAlignment: element.crossAxisAlignment.value,
        mainAxisSize: element.mainAxisSize.value,
        mainAxisAlignment: element.mainAxisAlignment.value,
        children: [
        ...getRowChildren(Axis.vertical),
    /*if(!hasExpanded())
          Flexible(
            child: _getArrow(Axis.vertical),
          ),*/
    ],
    );

    if (childrenIds.isEmpty) {
      row = SizedBox.expand(
        child: row,
      );
    }

    return wrapWithDefault(child: row);
    /*
    Widget row = GlobalDragTarget<String>(
      builder: (context, it, it2) {
        return Column(
          key: columnKey,
          crossAxisAlignment: element.crossAxisAlignment.value,
          mainAxisSize: element.mainAxisSize.value,
          mainAxisAlignment: element.mainAxisAlignment.value,
          children: getChildren2(),
        );
      },
      onAccept: (childId) {
        AppScope.of(context).widgetBoard.acceptChild(widget.id, childId, SlotData(
          slotName: "children",
          data: 0
        ));
      },
      onMove: (id, pos) {
        Widget widget = widgetBoard.getWidgetElementFromAnySource(id).generateWidget();
        int position = _calculateIndex(pos);

        print("Pos: $position");

        if(widget != toAdd || this.position != position) {
          setState(() {});
        }
        toAdd = widget;
        this.position = position;
        print("Colum moving $pos");
      },
    );

    if (childrenIds.isEmpty) {
      row = SizedBox.expand(
        child: row,
      );
    }

    return wrapWithDefault(child: row);*/
  }

  int _calculateIndex(Offset offset) {
    RenderFlex it = columnKey.currentContext.findRenderObject();
    RenderBox child = it.firstChild;

    double currentAxisPosition = 0;
    int i = 0;

    while (child != null) {

      if(offset.dy < currentAxisPosition + child.size.height / 2) {
        return i;
      }

      currentAxisPosition += child.size.height;
      final FlexParentData childParentData = child.parentData;
      child = childParentData.nextSibling;
      i++;
    }

    return i - 1;


  }

  List<Widget> getChildren2() {
    List<Widget> result = childrenIds
        .map((it) => widgetBoard.getWidgetElement(it).generateWidget())
        .toList();
    if(toAdd != null && position != null) {
      return result..insert(position, toAdd);
    }
    return result;
  }
}
