import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Expanded.dart';
import 'base.dart';

class ExpandedElementWidget extends StatefulWidget with ElementWidgetMixin {
  ExpandedElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _ExpandedElementWidgetState createState() => _ExpandedElementWidgetState();
}

class _ExpandedElementWidgetState extends State<ExpandedElementWidget> with ElementWidgetStateMixin<ExpandedElement, ExpandedElementWidget> {

  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: widgetBoard.getWidgetElement(element.findIdForSlot("child"))?.generateWidget() ?? DefaultDragTarget(id: widget.id,)
    );
  }

}
