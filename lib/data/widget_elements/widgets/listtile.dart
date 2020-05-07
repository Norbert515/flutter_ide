import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/ListTile.dart';

import 'base.dart';

class ListTileElementWidget extends StatefulWidget with ElementWidgetMixin {
  ListTileElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _ListTileElementWidgetState createState() => _ListTileElementWidgetState();
}

class _ListTileElementWidgetState extends State<ListTileElementWidget> with ElementWidgetStateMixin<ListTileElement, ListTileElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: ListTile(
          leading: getChildOrDragTarget(
            childId: element.findIdForSlot(ListTileElement.LEADING),
            data: SlotData(slotName: ListTileElement.LEADING),
            widgetWrapper: (context, widget) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth / 5,
                    child: widget,
                    height: 50,
                  );
                },
              );
            }
          ),title: getChildOrDragTarget(
          childId: element.findIdForSlot(ListTileElement.TITLE),
          data: SlotData(slotName: ListTileElement.TITLE),
          widgetWrapper: (context, widget) => sizeWidgetWrapper(context, Size(double.infinity, 50), widget),
        ),          subtitle: getChildOrDragTarget(
          childId: element.findIdForSlot(ListTileElement.SUBTITLE),
          data: SlotData(slotName: ListTileElement.SUBTITLE),
          widgetWrapper: (context, widget) => sizeWidgetWrapper(context, Size(double.infinity, 50), widget),
        ),          trailing: getChildOrDragTarget(
            widgetWrapper: (context, widget) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth / 5,
                    child: widget,
                    height: 50,
                  );
                },
              );
            },
          childId: element.findIdForSlot(ListTileElement.TRAILING),
          data: SlotData(slotName: ListTileElement.TRAILING),
        ),
          isThreeLine: element.isThreeLine.value,
          dense: element.dense.value,
          contentPadding: element.contentPadding.value,
          enabled: element.enabled.value,
        )
    );
  }

}