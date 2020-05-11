import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/WNetworkImage.dart';

import 'base.dart';

class ImageElementWidget extends StatefulWidget with ElementWidgetMixin {
  ImageElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _ImageElementWidgetState createState() => _ImageElementWidgetState ();
}

class _ImageElementWidgetState extends State<ImageElementWidget> with ElementWidgetStateMixin<WNetworkImageElement, ImageElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Image.network(element.src.value,
          height: element.height.value,
          width: element.width.value,
          fit: element.fit.value,
        ));
  }

}