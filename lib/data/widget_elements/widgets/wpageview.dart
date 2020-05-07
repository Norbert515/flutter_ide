import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/WPageView.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/list_helpers.dart';

import 'base.dart';

class PageViewElementWidget extends StatefulWidget with ElementWidgetMixin {
  PageViewElementWidget({this.id}) : super(key: GlobalObjectKey(id));

  final String id;

  @override
  _PageViewElementWidgetState createState() => _PageViewElementWidgetState();
}

class _PageViewElementWidgetState extends State<PageViewElementWidget> with ElementWidgetStateMixin<WPageViewElement, PageViewElementWidget>,
    ListElementWidgetStateMixin {

  PageController controller;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (childrenIds.isEmpty) {
      return getArrow(Axis.horizontal);
    }
    return wrapWithDefault(
        child: PageView(
          controller: controller,
          children: getRowChildren(Axis.horizontal),
          pageSnapping: element.pageSnapping.value,
        )
    );
  }

}
