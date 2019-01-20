import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';

class VisualContainer extends VisualStatefulWidget {

  VisualContainer({
    String id,
    this.color,
    this.width,
    this.height,
    this.child,
    this.constraints,
    Map<String, Property> properties,
    List<WidgetProperty> widgetProperties
  }) : super(id: id, key: GlobalKey<VisualState>(), properties: properties, widgetProperties: widgetProperties);

  final Widget child;
  final Color color;
  final double width;
  final double height;
  final BoxConstraints constraints;


  @override
  _VisualContainerState createState() => _VisualContainerState();

  @override
  String get originalClassName => "Container";
}

class _VisualContainerState extends VisualState<VisualContainer> {


  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      child: LayoutDragTarget(
        key: childKey,
        replacementActive: Container(height: 10, width: 10, color: Colors.orange,),
        replacementInactive: Container(height: double.infinity, width: double.infinity, color: Colors.transparent,),
        child: widget.child
      ),
      color: getValue<Color>('color'),
      width: getValue<double>('width'),
      height: getValue<double>('height'),
      padding: getValue<EdgeInsets>('padding'),
      margin: getValue<EdgeInsets>('margin'),
      alignment: getValue<Alignment>('alignment'),
      constraints: getValue<BoxConstraints>('constraints'),
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
  Map<String, Property> initRemoteValues() => {
    'color': ColorProperty(color: widget.color),
    'width': DoubleProperty(data: widget.width),
    'height': DoubleProperty(data: widget.height),
    'alignment': AlignmentProperty(alignment: Alignment.center),
    'padding': EdgeInsertsProperty(data: EdgeInsets.all(0)),
    'margin': EdgeInsertsProperty(data: EdgeInsets.all(0)),
    'constraints': BoxConstraintsProperty(data: BoxConstraints()),

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
    Map<String, Property> properties,
    List<WidgetProperty> widgetProperties,
    @required String id,
  }) : super(
    key: GlobalObjectKey<VisualState>(id),
    id: id,
    properties: properties?? const {},
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
  Widget buildWidget(BuildContext context) {
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

  @override
  // TODO: implement remoteValues
  Map<String, Property> initRemoteValues() => {};
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
    Map<String, Property> properties,
    List<WidgetProperty> widgetProperties,
    @required String id,
  }) : super(
      key: GlobalObjectKey<VisualState>(id),
      id: id,
      properties: properties?? const {},
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
  Widget buildWidget(BuildContext context) {
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

  @override
  // TODO: implement remoteValues
  Map<String, Property> initRemoteValues() => {};
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
