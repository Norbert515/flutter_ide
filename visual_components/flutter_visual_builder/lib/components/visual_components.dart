

import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/dynamic_widget.dart';
import 'package:flutter_visual_builder/main.dart';

/// TODO
/// Even though it is a bit tedious, each widget which should have the ability to change
/// needs to be wrapped in a corresponding visual element, which the App-Linker
/// can later change it to.
///
/// This is because
/// a) It needs to define how children can be changed/ moved
/// b) It needs to connect to the local server and send/ accept property changes
///
/// At some later point, this could be automated using code generation
///
///
/// TODO
/// Being consistent with different framework versions.
/// Because the framework is always evolving, changes in the framework can happen
/// which lead to property changes. Because of that, these widgets need to be updated
/// on a regular basis.
///
/// This shouldn't be too much of a problem because the changes are minimal and there
/// could be different widgets for each framework version (when starting this, we have
/// access to the framework version)
class VisualFloatingActionButton extends StatelessWidget {

  const VisualFloatingActionButton({
    Key key,
    this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.heroTag,
    this.elevation = 6.0,
    this.highlightElevation = 12.0,
    @required this.onPressed,
    this.mini = false,
    this.shape = const CircleBorder(),
    this.clipBehavior = Clip.none,
    this.materialTapTargetSize,
    this.isExtended = false,
  }) : super(key: key);


  final Widget child;

  final String tooltip;

  final Color foregroundColor;

  final Color backgroundColor;

  final Object heroTag;

  final VoidCallback onPressed;

  final double elevation;

  final double highlightElevation;

  final bool mini;

  final ShapeBorder shape;

  final Clip clipBehavior;

  final bool isExtended;

  final MaterialTapTargetSize materialTapTargetSize;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: LayoutDragTarget(
        child: child,
        replacementActive: Container(width: 20, height: 20, color: Colors.yellow,),
        replacementInactive: Container(width: 20, height: 20, color: Colors.red,),
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      heroTag: heroTag,
      shape: shape,
      clipBehavior: clipBehavior,
      mini: mini,
      foregroundColor: foregroundColor,
      highlightElevation: highlightElevation,
      isExtended: isExtended,
      materialTapTargetSize: materialTapTargetSize,
      tooltip: tooltip,
    );
  }
}

class VisualScaffold extends StatelessWidget {
  const VisualScaffold({
    Key key,
    this.visualMode,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomPadding = true,
    this.primary = true,
  }) : super(key: key);

  final bool visualMode;


  final PreferredSizeWidget appBar;

  final Widget body;

  final Widget floatingActionButton;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final FloatingActionButtonAnimator floatingActionButtonAnimator;

  final List<Widget> persistentFooterButtons;

  final Widget drawer;

  final Widget endDrawer;

  final Color backgroundColor;

  final Widget bottomNavigationBar;

  final Widget bottomSheet;

  final bool resizeToAvoidBottomPadding;

  final bool primary;

  // TODO inside maybe differenciate between center and normal etc.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      primary: primary,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      body: LayoutDragTarget(
        child: body,
        replacementActive: Container(constraints: BoxConstraints.expand(), color: Colors.yellow,),
        replacementInactive: Container(constraints: BoxConstraints.expand(), color: Colors.red,),
      ),
      floatingActionButton: LayoutDragTarget(
        child: floatingActionButton,
        replacementActive: Container(height: 50, width: 50, color: Colors.blue),
        replacementInactive: Container(height: 50, width: 50, color: Colors.pink),
      ),
      appBar: AppBarHeightWidgetWidget(child: LayoutDragTarget(
        child: appBar,
        feedback: SizedBox(
          width: 200,
          height: 52,
          child: appBar,
        ),
        replacementActive: Container(color: Colors.yellow, width: double.infinity,),
        replacementInactive: Container(color: Colors.purple, width: double.infinity,),
      )),
    );
  }
}



class AppBarHeightWidgetWidget extends StatelessWidget implements PreferredSizeWidget{

  const AppBarHeightWidgetWidget({Key key, this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return child;
  }


  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}



class LayoutDragTarget extends StatefulWidget {

  const LayoutDragTarget({
    Key key,
    @required this.replacementActive,
    @required this.replacementInactive,
    @required this.child,
    Widget feedback
  }) : feedback = feedback?? child, super(key: key);

  /// Maybe be null
  final Widget child;

  final Widget feedback;

  final Widget replacementActive;
  final Widget replacementInactive;

  @override
  LayoutDragTargetState createState() => LayoutDragTargetState();

}

class LayoutDragTargetState extends State<LayoutDragTarget> {

  bool active = false;

  DynamicWidget child;

  @override
  void initState() {
    super.initState();
   // child = DynamicWidget(widget.child, null);
    if(widget.child != null) {

      /// The visual editor only allows editing and changing widget which are
      /// contained in the opened widget (for now)
      ///
      ///
      /// TODO get the source code of the widget
      /// This needs to be done by the IDE
      ///
      /// When switching in the layout mode the IDE does two step to modify the source
      /// code
      /// 1. Replace every widget with it's corresponding visual widget.
      /// All the Flutter widgets have a replacement, others need to be implemented
      /// (which, with code general, should be super simple)
      ///
      /// 2. Constructor parameters of known widgets (knowing in the sense of
      /// having a visual variant) are scanned. Every widget which does not have
      /// a visual variant (either because it is unknown or id doesn't layout others
      /// like a text for example) are replaced with a widget which also contains
      /// its source code
      ///
      /// Examples:
      ///
      /// VisualScaffold(
      ///  body: Text("Hey")
      /// );
      ///
      /// is converted to
      ///
      /// VisualScaffold(
      ///   body: DynamicWidget(Text("Hey"), "Text("Hey")"),
      /// );
      ///
      /// This works with all sorts of arguments, because the value is merely copied.
      ///
      /// Widget text = getWidget("Hey");
      /// return VisualScaffold(
      ///   body: text
      /// );
      ///
      /// is converted to
      ///
      /// Widget text = getWidget("Hey"); //Untouched
      /// return VisualScaffold(
      ///   body: DynamicWidget(text, "text"),
      /// );
      ///
      ///
      /// This way the text is also draggable around on the screen.
      ///
      ///
      /// When everything is converted back, TODO
      child = wrapInVisualDraggable(DynamicWidget(widget.child, null, feedback: widget.feedback));
    } else {
      child = DynamicWidget(null, null, feedback: widget.feedback);
    }
  }


  DynamicWidget wrapInVisualDraggable(DynamicWidget widget) {
    return DynamicWidget(
        Draggable<DynamicWidget>(
          feedback: widget.feedback,
          child: widget.widget,
          childWhenDragging: SizedBox(),
          data: widget,
          onDragCompleted: () {
            reset();
          },
          onDragEnd: (details) {
            if(details.wasAccepted) {
              reset();
            }
          },
        ), widget.sourceCode);
  }

  void reset() {
    child = DynamicWidget.empty();
    active = false;
    if(mounted) setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return child.widget?? DragTarget<DynamicWidget>(
      builder: (context, it, it2) {
        return active? widget.replacementActive: widget.replacementInactive;
      },
      onWillAccept: (_) {
        setState(() {
          active = true;
        });
        return true;
      },
      onLeave: (_) {
        setState(() {
          active = false;
        });
      },
      onAccept: (it) {
        setState(() {
          child = wrapInVisualDraggable(it);
        });
      },

    );
  }
}

