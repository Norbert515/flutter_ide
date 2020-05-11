import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Scaffold.dart';

import 'base.dart';

class ScaffoldElementWidget extends StatefulWidget with ElementWidgetMixin {
  ScaffoldElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _ScaffoldElementWidgetState createState() => _ScaffoldElementWidgetState();
}

class _ScaffoldElementWidgetState extends State<ScaffoldElementWidget> 
    with ElementWidgetStateMixin<ScaffoldElement, ScaffoldElementWidget> {


  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Scaffold(
          body: getChildOrDragTarget(
              childId: element.findIdForSlot(ScaffoldElement.BODY),
              data:SlotData(slotName: ScaffoldElement.BODY,
              )),
          floatingActionButton: widgetBoard.getWidgetElement(element.findIdForSlot(ScaffoldElement.FLOATINGACTIONBUTTON))?.generateWidget() ??
              SizedBox(height: 56, width: 56, child: DefaultDragTarget(id: widget.id, data: SlotData(slotName: ScaffoldElement.FLOATINGACTIONBUTTON),),),
          appBar: PreferredSize(preferredSize: Size.fromHeight(56), child: getChildOrDragTarget(
              childId: element.findIdForSlot(ScaffoldElement.APPBAR),
              data: SlotData(slotName: ScaffoldElement.APPBAR))?? SizedBox()),
          backgroundColor: element.backgroundColor.value,
        ));
  }

}
