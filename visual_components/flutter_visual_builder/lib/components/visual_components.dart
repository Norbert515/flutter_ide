import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/dynamic_widget.dart';
import 'package:flutter_visual_builder/main.dart';

/// Return back valid code.
///
/// return VisualScaffold(
///      appBar: AppBar(
///        title: Text("Test"),
///      ),
///      floatingActionButton: VisualFloatingActionButton(
///          onPressed: (){
///            print("Hey!");
///          }
///      ),
///    );
///
///
/// Needs to be turned back into source code after modification.
/// TODO make it work with stateful too
abstract class VisualWidget extends StatelessWidget {

  VisualWidget({Key key, this.properties, this.widgetProperties}): super(key: key);


  /// This is needed in the constructor because we need to save the widget properties so we can restore the source code during runtime
  ///
  /// FOR NOW THESE CAN NOT BE CHANGED
  /// TODO when the server allows to change these, this need to be computed in a getter too.
  final List<Property> properties;

  /// Same for the widgets.
  final List<WidgetProperty> widgetProperties;


  /// The class name of the Widget which the Visual widget is replicating
  String get originalClassName;



  List<WidgetProperty> get modifiedWidgetProperties;

  /// Builds the source code for this specific VisualWidget
  ///
  /// It does it by first looking at all the parameters which are not widgets (which need no recursive steps)
  /// and then at the Dynamic widgets.
  String buildSourceCode() {
    return
      '$originalClassName(\n'
        '${properties.map((it) => '${it.name}:${it.value}').join(",\n")}\n'
        '${modifiedWidgetProperties.map((it) => '${it.name}:${it.dynamicWidget.sourceCode}').join(",\n")}'
        ')';
  }
}




/// This contains the properties as source code which would be lost otherwise when accessed at runtime.
///
/// For example:
///
/// return Container(
///   color: myColor,
/// );
///
/// Would evaluate to "myColor" during runtime, but we'd like to keep the variable, therefore
/// it is saved as:
///
/// Property("color", "myColor")
class Property {

  Property(this.name, this.value);

  final String name;
  final String value;

}

/// This is a property involving a layout widget.
class WidgetProperty {

  WidgetProperty({this.name, this.dynamicWidget});

  final String name;
  final DynamicWidget dynamicWidget;

}


class VisualRoot extends StatefulWidget {

  const VisualRoot({Key key, this.child}) : super(key: key);

  final VisualWidget child;

  @override
  VisualRootState createState() => VisualRootState();
}

class VisualRootState extends State<VisualRoot> {


  /// Builds the source code for this specific VisualWidget
  ///
  /// It does it by first looking at all the parameters which are not widgets (which need no recursive steps)
  /// and then at the Dynamic widgets.
  String buildSourceCode() {
    return widget.child.buildSourceCode();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}



class VisualWrapper extends VisualWidget {

  VisualWrapper({Key key, this.child}): super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  // TODO: implement modifiedWidgetProperties
  List<WidgetProperty> get modifiedWidgetProperties => null;

  @override
  // TODO: implement originalClassName
  String get originalClassName => "Custom element";

}

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
class VisualFloatingActionButton extends VisualWidget {

  VisualFloatingActionButton({
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
    List<Property> properties,
    List<WidgetProperty> widgetProperties
  }) : super(key: key, properties: properties, widgetProperties: widgetProperties);


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

  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: LayoutDragTarget(
        key: childKey,
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

  @override
  String get originalClassName => "FloatingActionButton";

  @override
  List<WidgetProperty> get modifiedWidgetProperties => [
    WidgetProperty(
      name: "child",
      dynamicWidget: childKey.currentState?.child,
    ),
  ];
}

class VisualScaffold extends VisualWidget {
  VisualScaffold({
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
    List<Property> properties,
    List<WidgetProperty> widgetProperties
  }) : super(key: key, properties: properties, widgetProperties: widgetProperties);

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

  final GlobalKey<LayoutDragTargetState> bodyKey = GlobalKey();
  final GlobalKey<LayoutDragTargetState> fabKey= GlobalKey();
  final GlobalKey<LayoutDragTargetState> appBarKey= GlobalKey();

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
        key: bodyKey,
        child: body,
        replacementActive: Container(constraints: BoxConstraints.expand(), color: Colors.yellow,),
        replacementInactive: Container(constraints: BoxConstraints.expand(), color: Colors.red,),
      ),
      floatingActionButton: LayoutDragTarget(
        key: fabKey,
        child: floatingActionButton,
        replacementActive: Container(height: 50, width: 50, color: Colors.blue),
        replacementInactive: Container(height: 50, width: 50, color: Colors.pink),
      ),
      appBar: AppBarHeightWidgetWidget(child: LayoutDragTarget(
        key: appBarKey,
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

  @override
  String get originalClassName => "Scaffold";

  @override
  List<WidgetProperty> get modifiedWidgetProperties => [
    WidgetProperty(
      name: "body",
      dynamicWidget: bodyKey.currentState?.child
    ),
    WidgetProperty(
        name: "floatingActionButton",
        dynamicWidget: fabKey.currentState?.child
    ),
    WidgetProperty(
        name: "appBar",
        dynamicWidget: appBarKey.currentState?.child
    ),
  ];
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


  /// Whether it is currently hovered above
  bool active = false;


  /// The child of this [LayoutDragTargetState].
  ///
  /// For example in a FAB, this is going to be the center slot.
  /// In a Scaffold, this is the body, the FAB slot and the AppBar Slot.
  DynamicWidget child;

  @override
  void initState() {
    super.initState();
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


  /// TODO The problem is that the state is lost when the widget is started to being dragged around.
  ///
  /// For example a FAB with a child in it is only treated as the FAB it was with the parameters it was constructed with.
  ///
  /// This can only be called if there is no widget in the slot
  DynamicWidget wrapInVisualDraggable(DynamicWidget newChild) {
    assert(child == null || child.widget == null);


    Widget feedback = newChild.feedback;

    DynamicWidget getData() {
      print("Requested data");
      if(newChild.widget is VisualWidget) {
        print("Had a visual widget inside");

        VisualWidget visualWidget = newChild.widget as VisualWidget;
        print("The widget is ${visualWidget.originalClassName}");

        return newChild.copyWith(visualWidget: visualWidget);
      }
      return newChild;
    }

    return DynamicWidget(
        Draggable<DynamicWidget>(
          feedback: feedback,
          child: newChild.widget,
          childWhenDragging: SizedBox(),
          // TODO data is currently only used as of the parent. This means any child data is lost
          // Because the data is only read when the drag starts we can implement a method to get the data of the child recursively.
     //     data: newChild,
          data: getData(),
          onDragStarted: () {
            LayoutDragTargetState it = this;
            print("Drag started $it");
          },
          onDragCompleted: () {
            reset();
          },
          onDragEnd: (details) {
            if(details.wasAccepted) {
              reset();
            }
          },
        ), newChild.sourceCode);
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
      onAccept: (DynamicWidget dynamicWidget) {
        /// Here a dynamic widget is received.
        ///
        /// When this widget is moved around, the sub widgets also need to move.
        /// This is the parent of dynamicWidget.
        ///
        /// The tree looks for a Scaffold containing a container in the body and a floating action button with an icon inside:
        ///
        /// The Scaffold has a [LayoutDragTarget] for the body and one for the FAB.
        ///
        /// The [DynamicWidget] of the body contains the container.
        /// The [DynamicWidget] of the FAB contains the FAB and the the Icon (as a child in the [DynamicWidget])
        ///
        ///
        ///
        /// How does this work with a child which can accept multiple children?
        ///
        /// VisualScaffold has another VisualScaffold in the body:
        ///
        /// The body slot is a DragTarget with a DynamicWidget, it has a VisualScaffold in itself.
        setState(() {
          child = wrapInVisualDraggable(dynamicWidget);
        });
      },

    );
  }
}

