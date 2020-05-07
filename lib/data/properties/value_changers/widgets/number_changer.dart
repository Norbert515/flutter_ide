import 'package:flutter/scheduler.dart';
import 'package:widget_maker_2_0/material.dart';

import 'decoration.dart';

class NumberChanger extends StatefulWidget {
  NumberChanger({Key key, this.name, this.onUpdate,
    this.value, this.allowNegative = true, this.showDescription = true, this.updateEveryChange = false,
    this.isInt = false})
      : super(key: key);

  final String name;
  final ValueChanged<double> onUpdate;
  final double value;
  final bool allowNegative;
  final bool showDescription;
  final bool updateEveryChange;

  final bool isInt;

  @override
  NumberChangerState createState() {
    return NumberChangerState();
  }
}

class NumberChangerState
    extends State<NumberChanger> {
  final TextEditingController textEditingController = TextEditingController(text: "-");

  bool dragging = false;
  bool hovering = false;
  bool hovered = false;

  String lastInput;

  final FocusNode focusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    _updateTextController();

    if(widget.updateEveryChange) {
      textEditingController.addListener(() {
        update(textEditingController.text);
      });
    }

    focusNode.addListener(() {
      if(!focusNode.hasFocus) {
        update(textEditingController.text);
      }
    });
  }


  void _updateTextController() {
    if(widget.value == double.infinity) {
      textEditingController.text = "infinity";
    } else if(widget.value == double.negativeInfinity) {
      textEditingController.text = "-infinity";
    } else {
      textEditingController.text = widget.value?.toStringAsFixed(widget.isInt? 0: 2)?.toString();
    }
    lastInput = textEditingController.text;
  }

  @override
  void didUpdateWidget(NumberChanger oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateTextController();
  }

  @override
  void dispose() {
    if(!focusNode.hasFocus) {
      // TODO figure out why this was in here in the first place
      /*SchedulerBinding.instance.addPostFrameCallback((_) {
        update(textEditingController.text);
      });*/
    }
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  double stringToNumber(String value) {
    if(value == "infinity") {
      value = "Infinity";
    } else if(value == "-infinity") {
      value = "-Infinity";
    }
    return double.tryParse(value);
  }

  void update(String value) {
    if(value == "") {
      widget.onUpdate(null);
      lastInput = null;
      return;
    }
    if(isValidString(value)) {
      if(value.isEmpty) return;
      var val = stringToNumber(value);
      widget.onUpdate(val);
      lastInput = value;
    } else {
      textEditingController.text = lastInput;
    }
  }

  bool isValidString(String value) {
    if(value.isEmpty) return true;
    var val = stringToNumber(value);

    if(val == null) return false;
    return isValidNumber(val);
  }

  bool isValidNumber(double number) {
    if(number < 0 && !widget.allowNegative) return false;
    return true;
  }

  void onDragUpdate(DragUpdateDetails update) {
    var number = stringToNumber(textEditingController.text);
    var newNumber = 0.0;
    if (number != null) newNumber = number;

    newNumber += update.primaryDelta * -1;
    if(isValidNumber(newNumber))
      widget.onUpdate(newNumber);
    //textEditingController.text = newNumber.toString();
  }

  void setCursor() {
    //CursorManager.instance.setCursor(CursorType.ResizeY);
  }

  void resetCursor() {
   // if (!dragging && !hovering) CursorManager.instance.resetCursor();
  }

  InputDecoration get decoration => hovering?
  MyDecorations.inputDecoration : InputDecoration(
    border: InputBorder.none
  );

  void handleHoverChange(bool hover) {
    if(hover != this.hovering) {
      setState(() {
        hovering = hover;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: Colors.red
        ),
        child: IntrinsicHeight(
          child: TextField(
            maxLines: 1,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1,
            controller: textEditingController,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.5)
                )
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.5)
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.5)
                )
              ),
              contentPadding: const EdgeInsets.all(8),
              helperText: widget.showDescription? widget.name: null,
              helperStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.5)
                )
              )
            ),
            onSubmitted: update,
           // onEditingComplete: ,
          ),
        ),
      )
    );
  }
}