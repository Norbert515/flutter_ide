import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets/desktop/hover/cursor_widget.dart';

class NumericChangeableTextField extends StatelessWidget {


  NumericChangeableTextField({Key key, this.name, this.onUpdate}) : super(key: key);

  final String name;

  final TextEditingController textEditingController = TextEditingController(text: "0");

  final ValueChanged<double> onUpdate;


  double stringToNumber(String value) {
    return double.tryParse(value);
  }


  void update(String value){
    var val = stringToNumber(value);
    if(val != null) {
      onUpdate(val);
    }
  }

  void onDragUpdate(DragUpdateDetails update) {
    var number = stringToNumber(textEditingController.text);
    var newNumber = 0.0;
    if(number != null) newNumber = number;

    newNumber += update.primaryDelta * -1;
    onUpdate(newNumber);
    textEditingController.text = newNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onVerticalDragUpdate: onDragUpdate,
          child: CursorWidget(
            cursorType: CursorType.ResizeY,
            child: SizedBox(
              width: 40,
              child: TextField(
                controller: textEditingController,
                onSubmitted: update
              ),
            ),
          ),
        ),
        Text(name)
      ],
    );
  }
}
