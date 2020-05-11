import 'package:widget_maker_2_0/data/widget_elements/base/meta.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/ui/theme.dart';
import 'package:widget_maker_2_0/ui/widgets/general/simple_2D_canvas.dart';

import 'base.dart';

class CanvasElementWidget extends StatefulWidget with ElementWidgetMixin {
  CanvasElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CanvasElementWidgetState createState() => _CanvasElementWidgetState();
}

class _CanvasElementWidgetState extends State<CanvasElementWidget> with ElementWidgetStateMixin<CanvasElement, CanvasElementWidget> {




  @override
  Widget getChildOrDragTarget({String childId, SlotData data, WidgetWrapper widgetWrapper}) {
    return widgetBoard.getWidgetElement(childId)?.generateWidget() ?? ElementDragTarget(id: widget.id, child: SizedBox.expand(), acceptingWidget: SizedBox.expand(),);
  }


  List<Widget> getControls() {
    if(isSelected) {
      return [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onPanStart: (_) {},
              onPanUpdate: (update) {
                element.position.updateValue(element.position.value + update.delta, context, element.id);
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
                child: Icon(Icons.open_with),
              ),
            ),
          ),
        ),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: wrapWithSelector(
              child: AnimatedContainer(
                alignment: Alignment.center,
                color: MyTheme.of(context).background2dp,
                duration: Duration(milliseconds: 300),
                width: element.canvasSize.value.width,
                height: element.canvasSize.value.height,
                child: getChildOrDragTarget(childId: element.childId),
            )),
          ),
        ),
        ...getControls()
      ],
    );
  }

}
