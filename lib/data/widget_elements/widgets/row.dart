import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/Row.dart';

import 'base.dart';
import 'list_helpers.dart';

class RowElementWidget extends StatefulWidget with ElementWidgetMixin {
  RowElementWidget({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _RowElementWidgetState createState() => _RowElementWidgetState();
}

class _RowElementWidgetState extends State<RowElementWidget>
    with ElementWidgetStateMixin<RowElement, RowElementWidget>, ListElementWidgetStateMixin{


  @override
  Widget build(BuildContext context) {
    if (childrenIds.isEmpty) {
      return getArrow(Axis.horizontal);
    }

    Widget row = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: element.mainAxisAlignment.value,
        crossAxisAlignment: element.crossAxisAlignment.value,
        textBaseline: element.textBaseline.value,
        textDirection: element.textDirection.value,
        children: [
        ...getRowChildren(Axis.horizontal),
    /*if(!hasExpanded() && element.mainAxisAlignment.value == MainAxisAlignment.start)
          Flexible(
            child: _getArrow(Axis.horizontal),
          ),*/
    ],
    );

    if (childrenIds.isEmpty) {
      row = SizedBox.expand(
        child: row,
      );
    }

    return wrapWithDefault(child: row);
  }

}