import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:flutter_visual_builder/widgets/key_resolver.dart';
import 'package:flutter/scheduler.dart';


// TODO hook up
class TreeView extends StatefulWidget {

  const TreeView({Key key, this.visualStatefulWidget, this.changed}) : super(key: key);

  final VisualStatefulWidget visualStatefulWidget;
  final ValueNotifier<bool> changed;

  @override
  TreeViewState createState() {
    return TreeViewState();
  }
}

class TreeViewState extends State<TreeView> {

  bool inited = false;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {inited = true;});
    });
    widget.changed.addListener(() {
      setState(() {});
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    if(!inited) return SizedBox();
    if(widget.visualStatefulWidget == null) {
      return Container(
        height: 50,
        child: Text("None"),
      );
    }
    return TreeNode(visualStatefulWidget: widget.visualStatefulWidget,changed: widget.changed,);
  }
}


class TreeNode extends StatelessWidget {
  TreeNode({Key key, this.visualStatefulWidget, this.changed})
      : visualState = keyResolver.map[visualStatefulWidget.id].currentState,
        super(key: key);

  final VisualStatefulWidget visualStatefulWidget;

  final VisualState visualState;


  final ValueNotifier<bool> changed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          width: 100,
          child: Text(visualState.widget.originalClassName),
        ),
      ]..addAll(getChildren()),
    );
  }

  List<Widget> getChildren() {
    return visualState.getWidgets().keys.map((key) {
      return Row(
        children: <Widget>[
          Text("$key: "),
          TreeView(
            changed: changed,
            visualStatefulWidget: visualState
                .getWidgets()[key].layoutDragTargetState.child,
          ),
        ],
      );
    }).toList();
  }
}
