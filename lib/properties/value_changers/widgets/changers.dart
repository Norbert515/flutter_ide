import 'package:flutter/material.dart';

import 'number_changer.dart';

class RoundNumberChanger extends StatelessWidget {

  const RoundNumberChanger({
    Key key,
    this.name,
    this.onUpdate,
    this.value,
    this.allowNegative = true,
    this.showDescription = true,
    this.isInt = false,
  }) : super(key: key);

  final String name;
  final ValueChanged<double> onUpdate;
  final double value;
  final bool allowNegative;
  final bool showDescription;
  final bool isInt;


  @override
  Widget build(BuildContext context) {
    Widget result = NumberChanger(
     onUpdate: onUpdate,
      value: value,
      allowNegative: allowNegative,
      isInt: isInt,
      showDescription: false,
    );

    if(showDescription) {

    }
    return RoundContainer(
      child: result
    );
  }
}


class RoundContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color color;

  const RoundContainer({Key key, this.child, this.width, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white
          ),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
      ),
      child: child,
    );
  }
}


class NotSupportedValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("This value is not yet supported");
  }
}
