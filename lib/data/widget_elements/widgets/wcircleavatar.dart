import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/WCircleAvatar.dart';

import 'base.dart';

class CircleAvatarElementWidget extends StatefulWidget with ElementWidgetMixin {
  CircleAvatarElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CircleAvatarElementWidgetState createState() => _CircleAvatarElementWidgetState();
}

class _CircleAvatarElementWidgetState extends State<CircleAvatarElementWidget> with ElementWidgetStateMixin<WCircleAvatarElement, CircleAvatarElementWidget> {

  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: CircleAvatar(
          child: getChildOrDragTarget(childId: element.findIdForSlot("child")),
          radius: element.radius.value,
          backgroundImage: NetworkImage(element.imageUrl.value),
        ));
  }

}