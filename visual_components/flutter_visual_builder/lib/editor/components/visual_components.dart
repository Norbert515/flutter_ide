import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/key_resolver.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:flutter_visual_builder/server/server.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:ide/utils/string_builder.dart';

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
    this.widgetProperties = const {},
    @required this.id
  }): assert(widgetProperties != null), assert(properties != null),super(key: key);


  // TODO This currently isn't _really_ used. I'll need to figure out a clever way
  // TODO of handling source code which is not trivial
  // TODO for example Container(color: myColorField);
  // In this case, should myColorField be editable? How is its value preserved
  // etc. This will be relevant when importing widgets
  /// This is needed in the constructor because we need to save the widget properties so we can restore the source code during runtime
  final Map<String, Property> properties;

  /// Same for the widgets.
  final Map<String, WidgetProperty> widgetProperties;


  /// The class name of the Widget which the Visual widget is replicating
  String get originalClassName;

  final String id;
}
abstract class VisualState<T extends VisualStatefulWidget> extends State<T> with PropertyStateMixin{

  Map<String, WidgetProperty> get modifiedWidgetProperties;

  /// This flag is only for the the Proxy width which should not register itself
  /// as editable widget
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
    // TODO a widget becomes tappable (can modify local state etc) when
    // a key modifier is pressed (for example strg). When that happens
    // the ignore pointer will be removed else it is there and the IDE
    // can intercept the events
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
  /// TODO formatting of end code
  String buildSourceCode() {
    StringBuilder stringBuilder = StringBuilder();
    stringBuilder.write('${widget.originalClassName}(\n');

    stringBuilder.addIndent();
    _buildProperties(stringBuilder);
    _buildWidgets(stringBuilder);
    stringBuilder.removeIndent();
    stringBuilder.writeNoIndent(")");


    return stringBuilder.toString();
  }

  void _buildProperties(StringBuilder builder) {
    remoteValues.forEach((key, property) {
      _generateProperty(key, property, builder);
    });
   // return '${remoteValues.map((key, prop) => _generateProperty(key, prop, builder)).values.join(",\n")}\n';
  }
  void _buildWidgets(StringBuilder builder) {

    modifiedWidgetProperties.forEach((key, property) {
      WidgetProperty that = property;
      if(property == null) {
        if(widget.widgetProperties.containsKey(key)) {
          that = widget.widgetProperties[key];
        }
      }
      if(that != null && that.dynamicWidget != null) {
        builder.write('$key:${keyResolver.map[that.dynamicWidget.id]?.currentState?.buildSourceCode()}');
        builder.writeNoIndent(',\n');
      }

    });

 /*   return modifiedWidgetProperties.entries.map((entry) {
      WidgetProperty that = entry.value;
      if(entry.value == null) {
        if(widget.widgetProperties.containsKey(entry.key)) {
          that = widget.widgetProperties[entry.key];
        }
        if(that == null) return;
      }
      if(that.dynamicWidget == null) {
        return;
      }

      return '   ${entry.key}:${keyResolver.map[that.dynamicWidget.id]?.currentState?.buildSourceCode()}';
    }).join(",\n");*/
  }

  void  _generateProperty(String key, Property property, StringBuilder builder) {
    if(property.data != null) {
      builder.write('$key:');
      property.fillSourceCode(builder);
      builder.writeNoIndent(",\n");
    }
   // return MapEntry(key, '   $key:${property.sourceCode}');


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
    assert(remoteValues != null);
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

  WidgetProperty({this.dynamicWidget});
  WidgetProperty.keyed(GlobalKey<LayoutDragTargetState> globalKey)
    : dynamicWidget = globalKey.currentState?.child;

  final VisualStatefulWidget dynamicWidget;

}


class VisualRoot extends StatefulWidget {

  const VisualRoot({Key key, this.child, this.onChanged}) : super(key: key);

  final VisualStatefulWidget child;
  final VoidCallback onChanged;

  @override
  VisualRootState createState() => VisualRootState();
}

class VisualRootState extends State<VisualRoot> {


  /// Builds the source code for this specific VisualWidget
  ///
  /// It does it by first looking at all the parameters which are not widgets (which need no recursive steps)
  /// and then at the Dynamic widgets.
  String buildSourceCode() {
    try {
      return keyResolver.map[widget.child.id].currentState.buildSourceCode();
    } catch(e) {

      if(e is Error) {
        print("Error $e \n ${e.stackTrace}");
      } else {
        print("Error $e");
      }
      return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SomethingChanged(
      onChange: widget.onChanged,
      child: widget.child
    );
  }
}

/// Used to notify the widget tree changed and thus the source code
/// needs to updated.
///
/// This is called when:
/// 1. A widget is inserted/deleted or moved
/// 2. A property is changed
///
/// To make adaption easier, instead of making the client invalidate itself
/// it gets a stream over the grpc connection delivering the latest source code
/// each change.
class SomethingChanged extends InheritedWidget {


  const SomethingChanged ({
    this.onChange,
    Widget child,
  }) : super(child: child);

  final VoidCallback onChange;

  static void notify(BuildContext context) {
    SomethingChanged it = context.inheritFromWidgetOfExactType(SomethingChanged);
    it.onChange();
  }

  @override
  bool updateShouldNotify(SomethingChanged oldWidget) {
    return true;
  }
}

class VisualWrapper extends VisualStatefulWidget {

  VisualWrapper({
    this.child,
    @required String id,
    @required this.sourceCode
  }): super(key: GlobalObjectKey<VisualState>(id), id:id);

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
  Map<String, WidgetProperty> get modifiedWidgetProperties => {};

  @override
  Map<String, Property> initRemoteValues() => {};

}

class VisualProxyWrapper extends VisualStatefulWidget {

  VisualProxyWrapper({
    this.child,
    this.visualWidget,
    @required String id,
  }): super(id: id);


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
  Map<String, WidgetProperty> get modifiedWidgetProperties => keyResolver.map[widget.visualWidget.id].currentState.modifiedWidgetProperties;

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
    this.replacementActive = const ActivePlaceholder(),
    this.replacementInactive = const InactivePlaceholder(),
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      SomethingChanged.notify(context);
    });
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
        SchedulerBinding.instance.addPostFrameCallback((_) {
          SomethingChanged.notify(context);
        });

        setState(() {
          child = wrapInVisualDraggable(dynamicWidget);
        });
      },

    );
  }
}

class ActivePlaceholder extends StatelessWidget {

  const ActivePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.green,
    );
  }
}

class InactivePlaceholder extends StatelessWidget {

  const InactivePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.blue,
    );
  }
}


