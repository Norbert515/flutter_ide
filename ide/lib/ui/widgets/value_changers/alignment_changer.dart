


import 'package:flutter/material.dart';
import 'value_changer.dart';

// TODO mixin best option?
/// Currently it is capped to alignment between -1 and 1
class AlignmentChanger extends StatefulWidget with ValueChanger<Alignment>{


  AlignmentChanger({Key key, this.onUpdate, this.value, this.size}) : super(key: key);

  final ValueChanged<Alignment> onUpdate;
  final Alignment value;
  final Size size;


  @override
  _AlignmentChangerState createState() => _AlignmentChangerState();
}

class _AlignmentChangerState extends State<AlignmentChanger> {


  Alignment alignment = Alignment.center;


  Offset offset;

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.size.width / 2, widget.size.height / 2);
  }

  void onPanUpdate(DragUpdateDetails details) {
    var delta = details.delta;

    setState(() {
      offset += delta;
    });
  }

  void onPanStart(DragStartDetails details) {
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(details.globalPosition);
    setState(() {
      offset = local;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        onPanStart: onPanStart,
        child: CustomPaint(
          painter: AlignmentPainter(
            offset: offset,
          ),
        ),
      ),
    );
  }


}


class AlignmentPainter extends CustomPainter {


  AlignmentPainter({this.offset});

  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white;

    // Draw border
    canvas.drawLine(Offset(0.0,0.0), Offset(size.width, 0.0), paint);
    canvas.drawLine(Offset(0.0,0.0), Offset(0.0, size.height), paint);
    canvas.drawLine(Offset(0.0,size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width,0.0), Offset(size.width, size.height), paint);



    double x = offset.dx;
    double y = offset.dy;

    if(x < 0) x = 0;
    if(y < 0) y = 0;
    if(x > size.width) x = size.width;
    if(y > size.height) y = size.height;

    canvas.drawRect(Rect.fromCircle(center: Offset(x,y), radius: 5), paint);
  }

  @override
  bool shouldRepaint(AlignmentPainter oldDelegate)
    => oldDelegate.offset != offset;

}