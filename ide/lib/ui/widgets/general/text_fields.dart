import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets/desktop/hover/cursor_widget.dart';
import 'package:flutter_desktop_widgets/desktop/hover/hoverable_element.dart';
import 'package:ide/themeing/ide_theme.dart';
/// Widget outside has to keep track of its state, similar to the radio button
class NumericChangeableTextField extends StatefulWidget {
  NumericChangeableTextField({Key key, this.name, this.onUpdate, this.value})
      : super(key: key);

  final String name;

  final ValueChanged<double> onUpdate;
  
  final double value;

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
  
  
  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.value.toString();
  }

  @override
  void didUpdateWidget(NumericChangeableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    textEditingController.text = widget.value.toString();
  }
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
    //textEditingController.text = newNumber.toString();
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
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.red
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(1),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        ),
                      )
                    ),
                    controller: textEditingController,
                    onSubmitted: update,
                    style: IDETheme.of(context)
                        .propertyChangerTheme
                        .propertyNumericValue,
                  ),
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