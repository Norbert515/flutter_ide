import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets/desktop/hover/cursor_widget.dart';
import 'package:flutter_desktop_widgets/desktop/hover/hoverable_element.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/widget_editors/common_editors.dart';
import 'package:ide/ui/widgets/general/text_fields.dart';


class ChangeableSize extends StatelessWidget with EditorMixin {
  ChangeableSize({Key key, this.id, this.widthKey, this.heightKey})
      : super(key: key);

  // TODO, optimally id won't have to be passed every time but it could use
  // a provider, need to figure out a nice way to incorporate that without hassle
  final String id;
  final String widthKey;
  final String heightKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text("Size",
                style: IDETheme.of(context)
                    .propertyChangerTheme
                    .propertyContainer)),
        Expanded(
          child: NumericChangeableTextField(
            name: "Width",
            onUpdate: (it) => sendUpdate(widthKey, DoubleProperty(data: it)),
          ),
        ),
        Expanded(
          child: NumericChangeableTextField(
            name: "Height",
            onUpdate: (it) => sendUpdate(heightKey, DoubleProperty(data: it)),
          ),
        ),
      ],
    );
  }
}

class ChangeableConstraints extends StatelessWidget {
  const ChangeableConstraints(
      {Key key,
      this.onMinWidthChange,
      this.onMaxWidgetChange,
      this.onMinHeightChange,
      this.onMaxHeightChange})
      : super(key: key);

  final ValueChanged<double> onMinWidthChange;
  final ValueChanged<double> onMaxWidgetChange;
  final ValueChanged<double> onMinHeightChange;
  final ValueChanged<double> onMaxHeightChange;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
