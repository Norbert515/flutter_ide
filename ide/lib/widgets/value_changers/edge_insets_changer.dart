import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/widgets/property_editor.dart';
import 'package:ide/widgets/widgets/general/text_fields.dart';

class ChangeableEdgeInsets extends StatefulWidget {
  ChangeableEdgeInsets(
      {Key key, this.id, this.propertyKey, this.value,})
      : super(key: key);

  final String id;
  final String propertyKey;
  final EdgeInsets value;

  @override
  ChangeableEdgeInsetsState createState() {
    return new ChangeableEdgeInsetsState ();
  }
}

class ChangeableEdgeInsetsState extends State<ChangeableEdgeInsets> with EditorMixin{


  @override
  String get id => widget.id;

  EdgeInsets edgeInsets;

  @override
  void initState() {
    super.initState();
    edgeInsets = widget.value;
  }


  void _update({double left, double top, double right, double bottom}) {

    edgeInsets = edgeInsets.copyWith(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );

    sendUpdate(context, widget.propertyKey, EdgeInsertsProperty (data: edgeInsets));
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: NumericChangeableTextField(
            onUpdate: (it) {
              _update(left: it);
            },
            value: edgeInsets.left,
            name: "left",
          ),
        ),
        Flexible(
          child: NumericChangeableTextField(
            onUpdate: (it) {
              _update(top: it);
            },
            value: edgeInsets.top,
            name: "top",
          ),
        ),
        Flexible(
          child: NumericChangeableTextField(
            onUpdate: (it) {
              _update(right: it);
            },
            value: edgeInsets.right,
            name: "right",
          ),
        ),
        Flexible(
          child: NumericChangeableTextField(
            onUpdate: (it) {
              _update(bottom: it);
            },
            value: edgeInsets.bottom,
            name: "bottom",
          ),
        ),
      ],
    );
  }

}