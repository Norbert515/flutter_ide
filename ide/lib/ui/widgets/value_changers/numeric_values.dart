import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets/desktop/hover/cursor_widget.dart';
import 'package:flutter_desktop_widgets/desktop/hover/hoverable_element.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/widget_editors/common_editors.dart';

class NumericChangeableTextField extends StatefulWidget {
  NumericChangeableTextField({Key key, this.name, this.onUpdate})
      : super(key: key);

  final String name;

  final ValueChanged<double> onUpdate;

  @override
  NumericChangeableTextFieldState createState() {
    return new NumericChangeableTextFieldState();
  }
}

class NumericChangeableTextFieldState
    extends State<NumericChangeableTextField> {
  final TextEditingController textEditingController =
      TextEditingController(text: "0");

  bool dragging = false;
  bool hovering = false;

  double stringToNumber(String value) {
    return double.tryParse(value);
  }

  void update(String value) {
    var val = stringToNumber(value);
    if (val != null) {
      widget.onUpdate(val);
    }
  }

  void onDragUpdate(DragUpdateDetails update) {
    var number = stringToNumber(textEditingController.text);
    var newNumber = 0.0;
    if (number != null) newNumber = number;

    newNumber += update.primaryDelta * -1;
    widget.onUpdate(newNumber);
    textEditingController.text = newNumber.toString();
  }

  void setCursor() {
    CursorManager.instance.setCursor(CursorType.ResizeY);
  }

  void resetCursor() {
    if (!dragging && !hovering) CursorManager.instance.resetCursor();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onVerticalDragUpdate: onDragUpdate,
          onVerticalDragStart: (_) {
            dragging = true;
            setCursor();
          },
          onVerticalDragCancel: () {
            dragging = false;
            resetCursor();
          },
          onVerticalDragEnd: (_) {
            dragging = false;
            resetCursor();
          },
          child: HoveringBuilder(
            onHoverStart: (it) {
              hovering = true;
              setCursor();
            },
            onHoverEnd: () {
              hovering = false;
              resetCursor();
            },
            builder: (context, hovering) {
              return SizedBox(
                width: 40,
                child: TextField(
                  controller: textEditingController,
                  onSubmitted: update,
                  style: IDETheme.of(context)
                      .propertyChangerTheme
                      .propertyNumericValue,
                ),
              );
            },
          ),
        ),
        Text(
          widget.name,
          style: IDETheme.of(context).propertyChangerTheme.propertyName,
        )
      ],
    );
  }
}

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
