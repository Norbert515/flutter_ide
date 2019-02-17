import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/widgets/property_editor.dart';
import 'package:ide/widgets/widgets/general/text_fields.dart';

class ChangeableConstraints extends StatefulWidget {
  ChangeableConstraints(
      {Key key, this.id, this.propertyKey, this.value,})
      : super(key: key);

  final String id;
  final String propertyKey;
  final BoxConstraints value;

  @override
  ChangeableConstraintsState createState() {
    return new ChangeableConstraintsState();
  }
}

class ChangeableConstraintsState extends State<ChangeableConstraints> with EditorMixin{


  @override
  String get id => widget.id;

  BoxConstraints constraints;

  @override
  void initState() {
    super.initState();
    constraints = widget.value;
  }


  void _update({double minWidth, double maxWidth, double minHeight, double maxHeight}) {

    constraints = constraints.copyWith(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );

    sendUpdate(context, widget.propertyKey, BoxConstraintsProperty(data: constraints));
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NumericChangeableTextField(
          onUpdate: (it) {
            _update(minWidth: it);
          },
          value: constraints.minWidth,
          name: "minWidth",
        ),
        NumericChangeableTextField(
          onUpdate: (it) {
            _update(maxWidth: it);
          },
          value: constraints.maxWidth,
          name: "maxWidth",
        ),
        NumericChangeableTextField(
          onUpdate: (it) {
            _update(minHeight: it);
          },
          value: constraints.minHeight,
          name: "minHeight",
        ),
        NumericChangeableTextField(
          onUpdate: (it) {
            _update(maxHeight: it);
          },
          value: constraints.maxHeight,
          name: "maxHeight",
        ),
      ],
    );
  }

}