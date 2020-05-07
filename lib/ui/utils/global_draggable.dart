import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/material.dart';

typedef DragTargetMove<T> = void Function(T data, Offset localPosition);
typedef _OnDragEnd = void Function(Velocity velocity, Offset offset, bool wasAccepted);

/// A class which accepts draggable coming from the Flutter
/// [Draggable] class and also my own global draggable system for
/// programmatically starting drags (used for the quick actions)
class GlobalDragTarget<T> extends StatefulWidget {

  const GlobalDragTarget({Key key, this.builder, this.onAccept, this.onWillAccept, this.onMove}) : super(key: key);

  final DragTargetBuilder<T> builder;
  final DragTargetAccept<T> onAccept;
  final DragTargetMove<T> onMove;
  final DragTargetWillAccept<T> onWillAccept;

  @override
  _GlobalDragTargetState<T> createState() => _GlobalDragTargetState<T>();
}


class _GlobalDragTargetState<T> extends State<GlobalDragTarget<T>> {

  T data;

  bool didEnter(dynamic data) {
    // no eed for onWillAccept
    if (data is T && (widget.onWillAccept == null || widget.onWillAccept(data))) {
      setState(() {
        this.data = data;
      });
      return true;
    }
    return false;
  }

  void didMove(dynamic data, Offset localPosition) {
    widget.onMove?.call(data, localPosition);
  }

  void didLeave(dynamic data) {
    if (!mounted)
      return;
    setState(() {
      this.data = null;
    });
    // No need for onLeave
    /*if (widget.onLeave != null)
      widget.onLeave(avatar.data);*/
  }

  void didDrop(dynamic data) {
    if (!mounted)
      return;
    setState(() {
      this.data = null;
    });
    if (widget.onAccept != null && (widget.onWillAccept == null || widget.onWillAccept(data)))
      widget.onAccept(data);
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<T>(
      onWillAccept: widget.onWillAccept,
      onAccept: widget.onAccept,
      builder: (context, canidate, rejected) {
        return MetaData(
          metaData: this,
          behavior: HitTestBehavior.translucent,
          child: widget.builder(
            context,
            [...canidate, if(data != null) data],
            rejected,
          ),
        );
      },
    );
  }
}


Future<bool> startGlobalDrag<T>(BuildContext context, {T data, Widget feedback}) async {
  var completer = Completer<bool>();
  _GlobalDragAvatar<T>(
    feedback: feedback,
    overlayState: Overlay.of(context),
    data: data,
    completer: completer,
    context: context,
    initialPosition: CursorPositionWidget.of(context),
  );
  return completer.future;
}

class _GlobalDragAvatar<T> extends Drag{

  _GlobalDragAvatar({
    @required this.overlayState,
    Offset initialPosition,
    this.feedback,
    this.data,
    this.completer,
    this.context,
    this.onDragEnd,

  }) {
    _lastOffset = initialPosition;
    _entry = OverlayEntry(builder: _buildEntry);
    overlayState.insert(_entry);
  }

  OverlayEntry _entry;
  final OverlayState overlayState;
  final Widget feedback;
  final T data;
  final BuildContext context;
  final _OnDragEnd onDragEnd;

  final Completer completer;


  _GlobalDragTargetState entered;

  Offset _lastOffset;

  @override
  void cancel() {

  }

  @override
  void end(DragEndDetails details) { }

  @override
  void update(DragUpdateDetails details) {

  }

  void onHover(PointerHoverEvent event) {
    _updatePointer(event.position);
  }
  void _updatePointer(Offset position) {
    _lastOffset = position;
    _entry.markNeedsBuild();


    final BoxHitTestResult result = BoxHitTestResult();
    // ToDo no idea why this is not working, something is blocking it with an RenderAbsorbPoint
    //WidgetsBinding.instance.hitTest(result, _lastOffset);
    var box = context.findRenderObject() as RenderBox;
    box.hitTest(result, position: _lastOffset);

    final List<MapEntry<RenderMetaData,_GlobalDragTargetState<T>>> targets = _getDragTargets(result.path).toList();

    if(targets.isEmpty) {
      if(entered != null) {
        entered.didLeave(data);
        entered = null;
      }
      return;
    }
    if(targets.first.value != entered) {
      if(entered != null)
        entered.didLeave(data);
      targets.first.value.didEnter(data);
      entered = targets.first.value;
    } else {
      // We're inside the same drag target
      assert(targets.first.value == entered);
      entered.didMove(data, targets.first.key.globalToLocal(position));
    }

  }

  void onDown() {
    if (onDragEnd != null)
      onDragEnd(Velocity.zero, _lastOffset, entered != null);

    _updatePointer(_lastOffset);
    _entry.remove();
    entered?.didDrop(data);
    _entry = null;
    completer.complete(entered != null);
  }


  Iterable<MapEntry<RenderMetaData,_GlobalDragTargetState<T>>> _getDragTargets(Iterable<HitTestEntry> path) sync* {
    // Look for the RenderBoxes that corresponds to the hit target (the hit target
    // widgets build RenderMetaData boxes for us for this purpose).
    for (HitTestEntry entry in path) {
      if (entry.target is RenderMetaData) {
        final RenderMetaData renderMetaData = entry.target;
        if (renderMetaData.metaData is _GlobalDragTargetState<T>)
          yield MapEntry(renderMetaData, renderMetaData.metaData);
      }
    }
  }

  Widget _buildEntry(BuildContext context) {
   final RenderBox box = overlayState.context.findRenderObject();
   final Offset overlayTopLeft = box.localToGlobal(Offset.zero);
   return Positioned.fill(
     child: Listener(
       behavior: HitTestBehavior.opaque,
       onPointerHover: (d) => onHover(d),
       onPointerDown: (_) => onDown(),
       child: Stack(
         children: <Widget>[
           Positioned(
             left: _lastOffset.dx - overlayTopLeft.dx,
             top: _lastOffset.dy - overlayTopLeft.dy,
             child: IgnorePointer(
               child: feedback,
             ),
           ),
         ],
       ),
     ),
   );
  }

}


/// A widget that can be dragged from to a [DragTarget].
///
/// When a draggable widget recognizes the start of a drag gesture, it displays
/// a [feedback] widget that tracks the user's finger across the screen. If the
/// user lifts their finger while on top of a [DragTarget], that target is given
/// the opportunity to accept the [data] carried by the draggable.
///
/// On multitouch devices, multiple drags can occur simultaneously because there
/// can be multiple pointers in contact with the device at once. To limit the
/// number of simultaneous drags, use the [maxSimultaneousDrags] property. The
/// default is to allow an unlimited number of simultaneous drags.
///
/// This widget displays [child] when zero drags are under way. If
/// [childWhenDragging] is non-null, this widget instead displays
/// [childWhenDragging] when one or more drags are underway. Otherwise, this
/// widget always displays [child].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=QzA4c4QHZCY}
///
/// See also:
///
///  * [DragTarget]
///  * [LongPressDraggable]
class GlobalDraggable<T> extends StatefulWidget {
  /// Creates a widget that can be dragged to a [DragTarget].
  ///
  /// The [child] and [feedback] arguments must not be null. If
  /// [maxSimultaneousDrags] is non-null, it must be non-negative.
  const GlobalDraggable({
    Key key,
    @required this.child,
    @required this.feedback,
    this.data,
    this.axis,
    this.childWhenDragging,
    this.feedbackOffset = Offset.zero,
    this.dragAnchor = DragAnchor.child,
    this.affinity,
    this.maxSimultaneousDrags,
    this.onDragStarted,
    this.onDraggableCanceled,
    this.onDragEnd,
    this.onDragCompleted,
    this.ignoringFeedbackSemantics = true,
  }) : assert(child != null),
        assert(feedback != null),
        assert(ignoringFeedbackSemantics != null),
        assert(maxSimultaneousDrags == null || maxSimultaneousDrags >= 0),
        super(key: key);


  final T data;
  final Axis axis;
  final Widget child;
  final Widget childWhenDragging;
  final Widget feedback;
  final Offset feedbackOffset;
  final DragAnchor dragAnchor;
  final bool ignoringFeedbackSemantics;
  final Axis affinity;
  final int maxSimultaneousDrags;
  final VoidCallback onDragStarted;
  final DraggableCanceledCallback onDraggableCanceled;
  final VoidCallback onDragCompleted;
  final DragEndCallback onDragEnd;

  @protected
  MultiDragGestureRecognizer<MultiDragPointerState> createRecognizer(GestureMultiDragStartCallback onStart) {
    switch (affinity) {
      case Axis.horizontal:
        return HorizontalMultiDragGestureRecognizer()..onStart = onStart;
      case Axis.vertical:
        return VerticalMultiDragGestureRecognizer()..onStart = onStart;
    }
    return ImmediateMultiDragGestureRecognizer()..onStart = onStart;
  }

  @override
  _DraggableState<T> createState() => _DraggableState<T>();
}

class _DraggableState<T> extends State<GlobalDraggable<T>> {
  @override
  void initState() {
    super.initState();
    _recognizer = widget.createRecognizer(_startDrag);
  }

  @override
  void dispose() {
    _disposeRecognizerIfInactive();
    super.dispose();
  }

  // This gesture recognizer has an unusual lifetime. We want to support the use
  // case of removing the Draggable from the tree in the middle of a drag. That
  // means we need to keep this recognizer alive after this state object has
  // been disposed because it's the one listening to the pointer events that are
  // driving the drag.
  //
  // We achieve that by keeping count of the number of active drags and only
  // disposing the gesture recognizer after (a) this state object has been
  // disposed and (b) there are no more active drags.
  GestureRecognizer _recognizer;
  int _activeCount = 0;

  void _disposeRecognizerIfInactive() {
    if (_activeCount > 0)
      return;
    _recognizer.dispose();
    _recognizer = null;
  }

  void _routePointer(PointerEvent event) {
    if (widget.maxSimultaneousDrags != null && _activeCount >= widget.maxSimultaneousDrags)
      return;
    _recognizer.addPointer(event);
  }

  _GlobalDragAvatar<T> _startDrag(Offset position) {
    if (widget.maxSimultaneousDrags != null && _activeCount >= widget.maxSimultaneousDrags)
      return null;
    Offset dragStartPoint;
    switch (widget.dragAnchor) {
      case DragAnchor.child:
        final RenderBox renderObject = context.findRenderObject();
        dragStartPoint = renderObject.globalToLocal(position);
        break;
      case DragAnchor.pointer:
        dragStartPoint = Offset.zero;
        break;
    }
    setState(() {
      _activeCount += 1;
    });
    final _GlobalDragAvatar<T> avatar = _GlobalDragAvatar<T>(
      overlayState: Overlay.of(context, debugRequiredFor: widget),
      data: widget.data,
      //axis: widget.axis,
      initialPosition: dragStartPoint,
      feedback: widget.feedback,
      context: context,
      //feedbackOffset: widget.feedbackOffset,
      //ignoringFeedbackSemantics: widget.ignoringFeedbackSemantics,
      onDragEnd: (Velocity velocity, Offset offset, bool wasAccepted) {
        if (mounted) {
          setState(() {
            _activeCount -= 1;
          });
        } else {
          _activeCount -= 1;
          _disposeRecognizerIfInactive();
        }
        if (mounted && widget.onDragEnd != null) {
          widget.onDragEnd(DraggableDetails(
              wasAccepted: wasAccepted,
              velocity: velocity,
              offset: offset,
          ));
        }
        if (wasAccepted && widget.onDragCompleted != null)
          widget.onDragCompleted();
        if (!wasAccepted && widget.onDraggableCanceled != null)
          widget.onDraggableCanceled(velocity, offset);
      },
    );
    if (widget.onDragStarted != null)
      widget.onDragStarted();
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    assert(Overlay.of(context, debugRequiredFor: widget) != null);
    final bool canDrag = widget.maxSimultaneousDrags == null ||
                         _activeCount < widget.maxSimultaneousDrags;
    final bool showChild = _activeCount == 0 || widget.childWhenDragging == null;
    return Listener(
      onPointerDown: canDrag ? _routePointer : null,
      child: showChild ? widget.child : widget.childWhenDragging,
    );
  }
}
