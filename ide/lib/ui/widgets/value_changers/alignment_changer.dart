


import 'package:flutter/material.dart';
import 'value_changer.dart';

// TODO mixin best option?
class AlignmentChanger extends StatefulWidget with ValueChanger<Alignment>{


  AlignmentChanger({Key key, this.onUpdate, this.value}) : super(key: key);

  final ValueChanged<Alignment> onUpdate;
  final Alignment value;


  @override
  _AlignmentChangerState createState() => _AlignmentChangerState();
}

class _AlignmentChangerState extends State<AlignmentChanger> {


  Alignment alignment = Alignment.center;



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class AlignmentPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }

}