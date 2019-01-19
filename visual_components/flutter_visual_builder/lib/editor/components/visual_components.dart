import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/dynamic_widget.dart';
import 'package:flutter_visual_builder/editor/main.dart';
import 'package:flutter_visual_builder/editor/key_resolver.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:flutter_visual_builder/server/server.dart';
import 'package:provider/provider.dart';

// TODO MetaData widget might also be interesting


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
/// TODO maybe make this a mixin?
abstract class VisualStatefulWidget extends StatefulWidget {

  VisualStatefulWidget({
    GlobalKey<VisualState> key,
    this.properties = const {},
    this.widgetProperties = const [],
    @required this.id
  }): super(key: key);


  /// This is needed in the constructor because we need to save the widget properties so we can restore the source code during runtime
  ///
  /// FOR NOW THESE CAN NOT BE CHANGED
  /// TODO when the server allows to change these, this need to be computed in a getter too
  /// TODO think of a way of handling these
  final Map<String, Property> properties;

  /// Same for the widgets.
  final List<WidgetProperty> widgetProperties;


  /// The class name of the Widget which the Visual widget is replicating
  String get originalClassName;

  final String id;
}
abstract class VisualState<T extends VisualStatefulWidget> extends State<T> with PropertyStateMixin{

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

  /// Instead of overwriting the build method overwrite this one
  Widget buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: buildWidget(context),
    );
  }


  void onTap() {
    // TODO Maybe move this out of there?
    EditorServer server = Provider.of<EditorServer>(context, listen: false);
    var result = SelectedWidgetWithProperties()
      ..id = widget.id
      ..type = widget.originalClassName;

    for(var key in remoteValues.keys) {
      Property property = remoteValues[key];
      result.properties[key] = json.encode(property.toMap());
    }
    print("Sending $result");
    server.updateSubject.add(result);
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
    return "Comment back in because this slows down code, but it looks cool";
   /* return
      '${widget.originalClassName}(\n'
          '${remoteValues.map((key, value) => MapEntry(key, '$key:${value.sourceCode}')).entries.join(",\n")}\n'
          '${modifiedWidgetProperties.map((it) {
        WidgetProperty that = it;
        if(it.dynamicWidget == null) {
          that = widget.widgetProperties.firstWhere((prop) => prop.name == it.name, orElse: () => null);
          if(that == null) return '';
        }
        return '${that.name}:${keyResolver.map[that.dynamicWidget.id]?.currentState?.buildSourceCode()}';

      }).join(",\n")}'
          ')';*/
  }

}


mixin PropertyStateMixin<T extends VisualStatefulWidget> on State<T> {

  /// TODO, this is a map, widgets is a list - choose one
  Map<String, Property> remoteValues;
  Map<String, Property> initRemoteValues();

  @override
  void initState() {
    super.initState();
    remoteValues = initRemoteValues();
  }

  void setValue<K>(String key, Property value) {
   if(remoteValues[key].runtimeType != value.runtimeType) {
      throw Exception("${remoteValues[key].runtimeType} and ${value.runtimeType}"
"do not have the same runtime type");
    }
    setState(() {
     remoteValues[key] = value;
    });
  }

  K getValue<K>(String key) {
    return remoteValues[key].data;
  }

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
  Widget buildWidget(BuildContext context) {
    return widget.child;
  }

  @override
  String buildSourceCode() {
    return widget.sourceCode;
  }

  @override
  List<WidgetProperty> get modifiedWidgetProperties => [];

  @override
  Map<String, Property> initRemoteValues() => {};

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
  Widget buildWidget(BuildContext context) {
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
/*
  @override
  Map<String, Property> initRemoteValues() => keyResolver.map[widget.visualWidget.id].currentState
  .remoteValues;
*/
  @override
  Map<String, Property> initRemoteValues() => {};
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

