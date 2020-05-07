import 'dart:math';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Expanded.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Flexible.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Row.dart';
import 'package:widget_maker_2_0/ui/utils/global_draggable.dart';

import 'base.dart';

class Arrow extends StatelessWidget {
  const Arrow({Key key, @required this.axis, @required this.color})
      : super(key: key);

  final Axis axis;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArrowPainter(axis, color),
    );
  }
}

class ArrowPainter extends CustomPainter {
  const ArrowPainter(this.axis, this.color);

  final Axis axis;
  final Color color;

  static const arrowTipSize = 20.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 5;

    if (axis == Axis.horizontal) {
      if (size.width < 5) return;

      var start = Offset(0, size.height / 2);
      var end = Offset(size.width, size.height / 2);

      var top = end + Offset(-arrowTipSize, arrowTipSize);
      var bottom = end + Offset(-arrowTipSize, -arrowTipSize);

      canvas.drawLine(start, end, paint);
      canvas.drawLine(end, top, paint);
      canvas.drawLine(end, bottom, paint);
    } else {
      if (size.height < 5) return;
      var start = Offset(size.width / 2, 0);
      var end = Offset(size.width / 2, size.height);

      var top = end + Offset(-arrowTipSize, -arrowTipSize);
      var bottom = end + Offset(arrowTipSize, -arrowTipSize);

      canvas.drawLine(start, end, paint);
      canvas.drawLine(end, top, paint);
      canvas.drawLine(end, bottom, paint);
    }
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => oldDelegate.axis != axis;
}

mixin ListElementWidgetStateMixin<A extends WidgetElement, T extends ElementWidgetMixin> on ElementWidgetStateMixin<A,T> {

  List<String> get childrenIds => element.children.where((it) => it.slotName == "children").first.childrenIds;


  Widget getArrow(Axis axis) {
    return ElementDragTarget(
      id: widget.id,
      data: SlotData(
        slotName: "children",
        data: 0
      ),
      acceptingWidget: LimitedBox(
        maxHeight: 100,
        maxWidth: 100,
        child: SizedBox.expand(
          child: Arrow(
            color: Colors.yellow,
            axis: axis,
          ),
        ),
      ),
      child: LimitedBox(
        maxHeight: 100,
        maxWidth: 100,
        child: SizedBox.expand(
          child: Arrow(
            color: Colors.indigo,
            axis: axis,
          ),
        ),
      ),
    );
  }


  Widget getRowElementWrapper(int index, Axis axis, {bool start= true}) {

    var side = const BorderSide(width: 8, color: Colors.blue);
    var noSide = BorderSide.none;

    return Expanded(
      child: GlobalDragTarget<String>(
        onAccept: (id) {

          // When moving a child, it is not delete from the widget
          // the drag is started, instead it is only not rendered
          // Thus, when moving an item inside the list
          // the position needs to accommodate for the past position
          // of the element that is moving
          int oldPosition;
          if(element.containsChild(id)) {
            SlotData oldData = element.getDataForChild(id);
            assert(oldData.data is int);
            oldPosition = oldData.data;
          }


          int insertAt;
          if(start) {
            insertAt = index + 1;
          } else {
            insertAt = index;
          }
          insertAt = max(0, insertAt);

          // This bug can only happen if the old position is smaller
          // as it influences the index it wants to be at
          if(oldPosition != null && oldPosition < index) {
            insertAt--;
          }

          AppScope.of(context).widgetBoard.acceptChild(widget.id, id, SlotData(
            slotName: "children",
            data: insertAt,
          ));
        },
        builder: (context, accepted, _) {
          if (accepted.isEmpty) {
            return SizedBox.expand();
          }
          return Container(
            decoration: BoxDecoration(
                border: Border(
                    right: axis == Axis.horizontal && start? side : noSide,
                    left: axis == Axis.horizontal && !start? side : noSide,
                    top: axis == Axis.vertical&& !start? side : noSide,
                    bottom: axis == Axis.vertical&& start? side : noSide,
                )
            )
          );
        },
      ),
    );
  }


  bool hasExpanded() {
    return childrenIds.map((it) => widgetBoard.getWidgetElement(it)).any((widgetElement) => widgetElement is ExpandedElement);
  }


  Widget _getOverlay(Axis axis, int i) {
    if(axis == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getRowElementWrapper(i, axis, start: false),
          Spacer(flex: 10,),
          getRowElementWrapper(i, axis, start: true),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getRowElementWrapper(i, axis, start: false),
          Spacer(flex: 10,),
          getRowElementWrapper(i, axis, start: true),
        ],
      );
    }
  }


  List<Widget> getRowChildren(Axis axis) {
    List<Widget> items = [];
    for (int i = 0; i < childrenIds.length; i++) {
      var widgetElement = widgetBoard.getWidgetElement(childrenIds[i]);

      Widget result = Stack(
        children: <Widget>[
          widgetBoard
              .getWidgetElement(childrenIds[i])
              .generateWidget(),
          Positioned.fill(
            child: _getOverlay(axis, i),
          ),
        ],
      );

      if(widgetElement is ExpandedElement) {
        // TODO wrap with expanded, and build its child -> problem updates
        // No problem row can register for expanded updates to

        // TODO care for memory leak
        widgetBoard.registerUpdate(widgetElement.id, rebuild);

        result = Expanded(
          flex: widgetElement.flex.value,
          child: result,
        );
      }

      if(widgetElement is FlexibleElement) {
        // TODO wrap with expanded, and build its child -> problem updates
        // No problem row can register for expanded updates to

        // TODO care for memory leak
        widgetBoard.registerUpdate(widgetElement.id, rebuild);

        result = Flexible(
          flex: widgetElement.flex.value,
          child: result,
        );
      }
      items.add(result);
    }

    return items;

  }

  void rebuild() {
    if(mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widgetBoard.removeUpdate(widget.id, refresh);
    super.dispose();
  }

  void acceptChild(RowElement element, String childId) {
    childrenIds.add(childId);
  }
}