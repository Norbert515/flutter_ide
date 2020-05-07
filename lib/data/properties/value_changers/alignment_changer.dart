import 'package:widget_maker_2_0/data/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/material.dart';


class AlignmentChanger extends StatelessValueChanger<Alignment> {


  final Size size;

  AlignmentChanger({Key key, Alignment value, ValueChanged<Alignment> onUpdate, this.size})
    : super(key: key, value: value, onUpdate: onUpdate);


  Offset get offset{
    return Offset(
      ((value.x + 1) / 2) * size.width,
      ((value.y + 1) / 2) * size.height,
    );
  }

  void _update(Offset newOffset) {
    var x = newOffset.dx / size.width;
    var y = newOffset.dy / size.height;

    // translate 0 - 1 to (-1) - 1
    var scaledX = x * 2 - 1;
    var scaledY = y * 2 - 1;

    Offset cappedOffset = _capOffset(minX: -1, maxX: 1, minY: -1, maxY: 1, offset: Offset(scaledX, scaledY));
    if (onUpdate != null) {
      // Cap the offset, even though this is allowed in Flutter, most of the times
      // it doesn't make sense.
      //
      // In the future there might be a way to remove this cap an visualize it neatly.
      // The problems were: Widget net being able to be dragged when outside of the align
      onUpdate(Alignment(cappedOffset.dx, cappedOffset.dy));
    }
    // alignment = Alignment(cappedOffset.dy, cappedOffset.dy);
  }

  void onPanUpdate(DragUpdateDetails details) {
    var delta = details.delta;
    _update(offset + delta);
  }

  void onPanStart(BuildContext context, DragStartDetails details) {
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(details.globalPosition);
    _update(local);
  }
  /*NumericChangeableTextField(
          name: "X",
          value: alignment.x,
        ),
        SizedBox(width: 8,),
        NumericChangeableTextField(
          name: "Y",
          value: alignment.y,
          onUpdate: (it) {

          },
        ),*/

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: size.height,
            width: size.width,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onPanStart: (it) => onPanStart(context, it),
              child: CustomPaint(
                painter: AlignmentPainter(
                  offset: offset,
                ),
              ),
            ),
          ),
          /*NumericChangeableTextField(
            name: "X",
            value: alignment.x,
          ),
          SizedBox(width: 8,),
          NumericChangeableTextField(
            name: "Y",
            value: alignment.y,
            onUpdate: (it) {

            },
          ),*/
        ],
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
    canvas.drawLine(Offset(0.0, 0.0), Offset(size.width, 0.0), paint);
    canvas.drawLine(Offset(0.0, 0.0), Offset(0.0, size.height), paint);
    canvas.drawLine(
        Offset(0.0, size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(
        Offset(size.width, 0.0), Offset(size.width, size.height), paint);

    canvas.drawRect(
        Rect.fromCircle(
            center:
            _capOffset(maxX: size.width, maxY: size.height, offset: offset),
            radius: 5),
        paint);
  }

  @override
  bool shouldRepaint(AlignmentPainter oldDelegate) =>
      oldDelegate.offset != offset;
}

Offset _capOffset(
    {double minX = 0,
      double minY = 0,
      @required double maxX,
      @required double maxY,
      @required Offset offset}) {
  double x = offset.dx;
  double y = offset.dy;

  if (x < minX) x = minX;
  if (y < minY) y = minY;
  if (x > maxX) x = maxX;
  if (y > maxY) y = maxY;

  return Offset(x, y);
}