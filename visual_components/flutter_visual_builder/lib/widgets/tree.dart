import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:flutter_visual_builder/widgets/key_resolver.dart';


// TODO hook up
class TreeView extends StatelessWidget {

  const TreeView({Key key, this.visualStatefulWidget}) : super(key: key);

  final VisualStatefulWidget visualStatefulWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TreeNode(visualStatefulWidget: visualStatefulWidget,),
        visualStatefulWidget,
      ],
    );
  }
}


class TreeNode extends StatelessWidget {
  TreeNode({Key key, this.visualStatefulWidget})
      : visualState = keyResolver.map[visualStatefulWidget.id].currentState,
        super(key: key);

  final VisualStatefulWidget visualStatefulWidget;

  final VisualState visualState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          width: 100,
          child: Text(visualState.widget.originalClassName),
        ),
      ],
    );
  }

  List<Widget> getChildren() {
    return visualState.modifiedWidgetProperties.keys.map((key) {
      return Row(
        children: <Widget>[
          Text("$key: "),
          TreeView(
            visualStatefulWidget: visualState
                .modifiedWidgetProperties[key].layoutDragTargetState.child,
          ),
        ],
      );
    }).toList();
  }
}
