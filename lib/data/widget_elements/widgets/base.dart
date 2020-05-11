import 'dart:async';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/app_scope/project.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/instanced_widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_maker_2_0/ui/board_widget.dart';
import 'package:widget_maker_2_0/data/app_scope/currently_dragging.dart';
import 'package:widget_maker_2_0/ui/utils/at_cursor_alert.dart';
import 'package:widget_maker_2_0/ui/utils/global_draggable.dart';

typedef AcceptChild<T extends WidgetElement> = void Function(T element, String childId);
typedef WidgetWrapper = Widget Function(BuildContext context, Widget child);

Widget sizeWidgetWrapper(BuildContext context, Size size, Widget child) {
  return SizedBox(
    width: size.width,
    height: size.height,
    child: child,
  );
}

mixin ElementWidgetMixin on StatefulWidget {
  String get id;
}

mixin ElementWidgetStateMixin<A extends WidgetElement, T extends ElementWidgetMixin> on State<T> {
  A element;

  bool isSelected = false;

  WidgetBoard widgetBoard;

  StreamSubscription _subscription;
  StreamSubscription _anotherSubscription;

  CurrentlyDraggingState currentlyDraggingState;

  /// Whether this widget is part of a reference widget
  bool isInReference;

  bool playMode;

  @override
  void initState() {
    super.initState();

    Project project = AppScope.of(context, listen: false);

    widgetBoard = project.widgetBoard;

    element = widgetBoard.getWidgetElementFromAnySource(widget.id);
    isSelected = widgetBoard.currentlySelectedValue == widget.id;

    isInReference = context.ancestorWidgetOfExactType(InstancedWidgetElementWidget) != null;


    playMode = project.playModeStream.value;
    _anotherSubscription = project.playModeStream.listen((it) {
      setState(() {
        playMode = it;
      });
    });

    widgetBoard.registerUpdate(widget.id, refresh);
    _subscription = widgetBoard.currentlySelected.listen((it) {
      isSelected = it == widget.id;
      refresh();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentlyDraggingState = Provider.of<CurrentlyDraggingState>(context);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _anotherSubscription.cancel();
    widgetBoard.removeUpdate(widget.id, refresh);
    super.dispose();
  }

  void refresh() {
    setState(() {
      element = widgetBoard.getWidgetElement(widget.id);
    });
  }


  /// Wrap the given child with widgets which take care of making it selectable and draggable
  Widget wrapWithDefault({Widget child}) {
    if(isInReference) {
      return child;
    }
    return wrapWithSelector(
      child: wrapWithDraggable(child: child)
    );
  }

  Widget wrapWithDraggable({Widget child}) {
    return Draggable<String>(
      maxSimultaneousDrags: playMode? 0: 1,
      data: element.id,
      child: child,
      onDragStarted: () {
        currentlyDraggingState.setDragging(true);
      },
      onDragEnd: (details) {
        if(!details.wasAccepted) {
          showDidNotAccept(context);
        }
        currentlyDraggingState.setDragging(false);
      },
      childWhenDragging: SizedBox(),
      feedback: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          child: child,
          constraints: BoxConstraints(
            maxHeight: 200,
            maxWidth: 200,
          ),

        ),
      ),
    );
  }

  Widget wrapWithSelector({Widget child}) {
    if(isInReference) {
      return child;
    }

    Widget result = child;
    // ToDO child is re-inflated here, fix this
    if (isSelected) {
      result = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          child,
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                ),
              ),
            ),
          ),
          Positioned(
            child: Text(element.name),
            top: -16,
            height: 16,
          ),
        ],
      );
    }

    return GestureDetector(
      child: result,
      onTap: playMode? null: () {
        widgetBoard.setSelected(widget.id);
      },
    );
  }



  Widget getChildOrDragTarget({String childId, SlotData data, WidgetWrapper widgetWrapper}) {
    Widget child = widgetBoard.getWidgetElement(childId)?.generateWidget();

    if(child != null) return child;

    if(playMode)
      return null;

    if(isInReference) {
      return SizedBox();
    }

    Widget result = DefaultDragTarget(id: widget.id, data: data,);

    if(widgetWrapper != null) {
      return widgetWrapper(context, result);
    }

    return result;

  }

}

/// Drag target for a widget element
///
/// Handles  accepting data and building drag feedback
class ElementDragTarget extends StatelessWidget {

  final Widget acceptingWidget;
  final Widget child;
  final String id;
  final SlotData data;
  final DragTargetMove<String> onMove;

  const ElementDragTarget({Key key, @required this.acceptingWidget, @required this.id, @required this.child, this.data, this.onMove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDragging = Provider.of<CurrentlyDraggingState>(context).isDragging;
    return StreamBuilder<String>(
      stream: AppScope.of(context).widgetBoard.currentlySelected,
      initialData: AppScope.of(context).widgetBoard.currentlySelectedValue,
      builder: (context, snapshot) {
        if(!isDragging && snapshot.data != id) return const SizedBox();

        return GlobalDragTarget<String>(
          onAccept: (childId) {
            AppScope.of(context).widgetBoard.acceptChild(this.id, childId, data);
          },
          onMove: onMove,
          builder: (context, accepted, rejected) {
            if (accepted.isNotEmpty) {
              return KeyedSubtree(child: acceptingWidget, key: ObjectKey(1),);
            } else {
              return KeyedSubtree(child: child, key: ObjectKey(2),);
            }
          },
        );
      }
    );
  }
}


class DefaultDragTarget extends StatelessWidget {

  const DefaultDragTarget({Key key, @required this.id, this.data}) : super(key: key);

  final String id;

  final SlotData data;

  @override
  Widget build(BuildContext context) {
    return ElementDragTarget(
      data: data,
      id: id,
      acceptingWidget: Placeholder(
        color: Colors.blue,
      ),
      child: Placeholder(
        color: Colors.green,
      ),
    );
  }
}
