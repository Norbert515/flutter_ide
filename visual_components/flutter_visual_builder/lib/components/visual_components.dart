import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/dynamic_widget.dart';
import 'package:flutter_visual_builder/main.dart';
import 'package:flutter_visual_builder/key_resolver.dart';

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
abstract class VisualStatefulWidget extends StatefulWidget {

  VisualStatefulWidget({
    GlobalKey<VisualState> key,
    this.properties = const [],
    this.widgetProperties = const [],
    @required this.id
  }): super(key: key);


  /// This is needed in the constructor because we need to save the widget properties so we can restore the source code during runtime
  ///
  /// FOR NOW THESE CAN NOT BE CHANGED
  /// TODO when the server allows to change these, this need to be computed in a getter too.
  final List<Property> properties;

  /// Same for the widgets.
  final List<WidgetProperty> widgetProperties;


  /// The class name of the Widget which the Visual widget is replicating
  String get originalClassName;

  final String id;
}
abstract class VisualState<T extends VisualStatefulWidget> extends State<T> {

  List<WidgetProperty> get modifiedWidgetProperties;


  bool get shouldRegister => true;

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(shouldRegister) {
      keyResolver.map[widget.id] = widget.key;
    }
  }

  @override
  void initState() {
    super.initState();
    if(shouldRegister) {
      // TODO this is getting called a bunch of times when hovering over the left size, why?
      print("New state with id registered: ${widget.id}");
      keyResolver.map[widget.id] = widget.key;
    }
  }

  @override
  void dispose() {
//    keyResolver.map.remove(widget.id);
    super.dispose();
  }

  /// Builds the source code for this specific VisualWidget
  ///
  /// It does it by first looking at all the parameters which are not widgets (which need no recursive steps)
  /// and then at the Dynamic widgets.
  String buildSourceCode() {
    return
      '${widget.originalClassName}(\n'
          '${widget.properties.map((it) => '${it.name}:${it.value}').join(",\n")}\n'
          '${modifiedWidgetProperties.map((it) {
        WidgetProperty that = it;
        if(it.dynamicWidget == null) {
          that = widget.widgetProperties.firstWhere((prop) => prop.name == it.name, orElse: () => null);
          if(that == null) return '';
        }
        return '${that.name}:${keyResolver.map[that.dynamicWidget.id]?.currentState?.buildSourceCode()}';

      }).join(",\n")}'
          ')';
  }

}


mixin RemoteStateMixin<T extends VisualStatefulWidget> on State<T> {

  Map<String, RemoteValue> get remoteValues;

  K getValue<K>(String key) {
    return remoteValues[key].value;
  }

}

class RemoteValue<T> {

  RemoteValue(this.value);

  final T value;
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

  Property({@required this.name, @required this.value});

  final String name;
  final String value;
}

/// This is a property involving a layout widget.
///
/// The difference to the Property is that this does not actually contain any code,
/// it only contains a Visual widget which in turn has Properties and WidgetProperties
class WidgetProperty {

  WidgetProperty({this.name, this.dynamicWidget});

  final String name;
  final VisualStatefulWidget dynamicWidget;

}


class VisualRoot extends StatefulWidget {

  const VisualRoot({Key key, this.child}) : super(key: key);

  final VisualStatefulWidget child;

  @override
  VisualRootState createState() => VisualRootState();
}

class VisualRootState extends State<VisualRoot> {


  /// Builds the source code for this specific VisualWidget
  ///
  /// It does it by first looking at all the parameters which are not widgets (which need no recursive steps)
  /// and then at the Dynamic widgets.
  String buildSourceCode() {
    return keyResolver.map[widget.child.id].currentState.buildSourceCode();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}


class VisualWrapper extends VisualStatefulWidget {

  VisualWrapper({
    this.child,
    @required String id,
    @required this.sourceCode
  }): super(key: GlobalKey(), id:id);

  final Widget child;

  final String sourceCode;

  @override
  String get originalClassName => "Custom element";

  @override
  _VisualWrapperState createState() => _VisualWrapperState();
}

class _VisualWrapperState extends VisualState<VisualWrapper> {


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  String buildSourceCode() {
    return widget.sourceCode;
  }

  @override
  List<WidgetProperty> get modifiedWidgetProperties => [];

}

class VisualProxyWrapper extends VisualStatefulWidget {

  VisualProxyWrapper({
    this.child,
    this.visualWidget,
    @required String id,
  }): super(key: GlobalKey(), id: id);


  final Widget child;
  final VisualStatefulWidget visualWidget;


  @override
  String get originalClassName => visualWidget.originalClassName;

  @override
  _VisualProxyWrapperState createState() => _VisualProxyWrapperState();
}

class _VisualProxyWrapperState extends VisualState<VisualProxyWrapper> {


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  List<WidgetProperty> get modifiedWidgetProperties => keyResolver.map[widget.visualWidget.id].currentState.modifiedWidgetProperties;

  @override
  String buildSourceCode() {
    return keyResolver.map[widget.visualWidget.id].currentState.buildSourceCode();
  }

  @override
  bool get shouldRegister => false;

}






class VisualContainer extends VisualStatefulWidget {

  VisualContainer({
    String id,
    this.color,
    this.width,
    this.height,
    this.child,
    List<Property> properties,
    List<WidgetProperty> widgetProperties
  }) : super(id: id, key: GlobalKey<VisualState>(), properties: properties, widgetProperties: widgetProperties);

  final Widget child;
  final Color color;
  final double width;
  final double height;


  @override
  _VisualContainerState createState() => _VisualContainerState();

  @override
  String get originalClassName => "Container";
}

class _VisualContainerState extends VisualState<VisualContainer> with RemoteStateMixin{


  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutDragTarget(
        key: childKey,
        replacementActive: Container(height: 10, width: 10, color: Colors.orange,),
        replacementInactive: Container(height: 10, width: 10, color: Colors.indigo,),
        child: widget.child
      ),
      color: getValue<Color>('color'),
      height: widget.height,
      width: widget.width,
    );
  }

  @override
  List<WidgetProperty> get modifiedWidgetProperties => [
    WidgetProperty(
      name: "child",
      dynamicWidget: childKey.currentState?.child,
    ),
  ];

  @override
  Map<String, RemoteValue> get remoteValues => {
    "color": RemoteValue<Color>(widget.color),
  };
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
class VisualFloatingActionButton extends VisualStatefulWidget {

  VisualFloatingActionButton({
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
    List<WidgetProperty> widgetProperties,
    @required String id,
  }) : super(
    key: GlobalKey<VisualState>(),
    id: id,
    properties: properties?? const [],
    widgetProperties: widgetProperties?? const [],
  );


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
  _VisualFloatingActionButtonState createState() => _VisualFloatingActionButtonState();


  @override
  String get originalClassName => "FloatingActionButton";
}

class _VisualFloatingActionButtonState extends VisualState<VisualFloatingActionButton> {

  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      child: LayoutDragTarget(
        key: childKey,
        child: widget.child,
        replacementActive: Container(width: 20, height: 20, color: Colors.yellow,),
        replacementInactive: Container(width: 20, height: 20, color: Colors.red,),
      ),
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      heroTag: widget.heroTag,
      shape: widget.shape,
      clipBehavior: widget.clipBehavior,
      mini: widget.mini,
      foregroundColor: widget.foregroundColor,
      highlightElevation: widget.highlightElevation,
      isExtended: widget.isExtended,
      materialTapTargetSize: widget.materialTapTargetSize,
      tooltip: widget.tooltip,
    );
  }

  @override
  List<WidgetProperty> get modifiedWidgetProperties => [
    WidgetProperty(
      name: "child",
      dynamicWidget: childKey.currentState?.child,
    ),
  ];
}


class VisualScaffold extends VisualStatefulWidget {

  VisualScaffold({
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
    List<WidgetProperty> widgetProperties,
    @required String id,
  }) : super(
      key: GlobalKey<VisualState>(),
      id: id,
      properties: properties?? const [],
      widgetProperties: widgetProperties?? [
        WidgetProperty(name: "body", dynamicWidget: body),
        WidgetProperty(name: "floatingActionButton", dynamicWidget: floatingActionButton)
      ]);

  final bool visualMode;

  final PreferredSizeWidget appBar;

  final VisualStatefulWidget body;

  final VisualStatefulWidget floatingActionButton;

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

  @override
  _VisualScaffoldState createState() => _VisualScaffoldState();


  @override
  String get originalClassName => "Scaffold";
}

class _VisualScaffoldState extends VisualState<VisualScaffold> {



  final GlobalKey<LayoutDragTargetState> bodyKey = GlobalKey();
  final GlobalKey<LayoutDragTargetState> fabKey= GlobalKey();
  final GlobalKey<LayoutDragTargetState> appBarKey= GlobalKey();


  // TODO inside maybe differenciate between center and normal etc.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      primary: widget.primary,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      body: LayoutDragTarget(
        key: bodyKey,
        child: widget.body,
        replacementActive: Container(constraints: BoxConstraints.expand(), color: Colors.yellow,),
        replacementInactive: Container(constraints: BoxConstraints.expand(), color: Colors.red,),
      ),
      floatingActionButton: LayoutDragTarget(
        key: fabKey,
        child: widget.floatingActionButton,
        replacementActive: Container(height: 50, width: 50, color: Colors.blue),
        replacementInactive: Container(height: 50, width: 50, color: Colors.pink),
      ),
      appBar: AppBarHeightWidgetWidget(child: LayoutDragTarget(
        key: appBarKey,
        child: widget.appBar,
        feedback: SizedBox(
          width: 200,
          height: 52,
          child: widget.appBar,
        ),
        replacementActive: Container(color: Colors.yellow, width: double.infinity,),
        replacementInactive: Container(color: Colors.purple, width: double.infinity,),
      )),
    );
  }
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


// TODO need a way to restore the state
class LayoutDragTarget extends StatefulWidget {

  const LayoutDragTarget({
    Key key,
    @required this.replacementActive,
    @required this.replacementInactive,
    @required this.child,
    this.onAccept,
    this.onLeave,
    Widget feedback
  }) : feedback = feedback?? child, super(key: key);

  /// Maybe be null
  final Widget child;

  final Widget feedback;

  final Widget replacementActive;
  final Widget replacementInactive;

  final VoidCallback onAccept;
  final VoidCallback onLeave;

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
  VisualStatefulWidget child;

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

      if(widget.child is VisualStatefulWidget) {
        VisualStatefulWidget it = widget.child as VisualStatefulWidget;
        child = wrapInVisualDraggable(VisualProxyWrapper(child: widget.child, visualWidget: it, id: it.id,));

      } else {
        assert(false);
        //child = wrapInVisualDraggable(VisualWrapper(child: widget.child, id: "SOME",));
      }
    } else {
      child = null;
    }
  }


  /// TODO The problem is that the state is lost when the widget is started to being dragged around.
  ///
  /// For example a FAB with a child in it is only treated as the FAB it was with the parameters it was constructed with.
  ///
  /// This can only be called if there is no widget in the slot
  VisualStatefulWidget wrapInVisualDraggable(VisualStatefulWidget newChild) {
    assert(child == null);
    return VisualProxyWrapper(
      id: newChild.id,
      visualWidget: newChild,
      child: Draggable<VisualStatefulWidget>(
        feedback: newChild,
        child: newChild,
        childWhenDragging: SizedBox(),
        data: newChild,
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
      ),
    );
  }

  void reset() {
    if(widget.onLeave != null) {
      widget.onLeave();
    }
    child = null;
    active = false;
    if(mounted) setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return child?? DragTarget<VisualStatefulWidget>(
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
      onAccept: (VisualStatefulWidget dynamicWidget) {
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


        if(widget.onAccept != null) {
          widget.onAccept();
        }

        setState(() {
          child = wrapInVisualDraggable(dynamicWidget);
        });
      },

    );
  }
}

