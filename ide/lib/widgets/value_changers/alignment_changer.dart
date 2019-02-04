import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';
import 'package:ide/widgets/widgets/general/text_fields.dart';
import 'package:ide/widgets/widget_editors/property_changers/property_editor.dart';

class AlignmentChanger extends StatelessWidget with EditorMixin {

  AlignmentChanger({Key key, this.propertyName, this.id, this.value}) : super(key: key);

  final String propertyName;
  final String id;
  final Alignment value;


  @override
  Widget build(BuildContext context) {
    return AlignmentBox(
      onUpdate: (it) =>  sendUpdate(context, propertyName, AlignmentProperty(alignment: it)),
      value: value,
      size: Size(50, 50),

    );
  }
}



// TODO mixin best option?
/// Currently it is capped to alignment between -1 and 1
class AlignmentBox extends StatefulWidget {
  AlignmentBox({Key key, this.onUpdate, this.value, this.size})
      : super(key: key);

  final ValueChanged<Alignment> onUpdate;
  final Alignment value;
  final Size size;


  @override
  _AlignmentBoxState createState() => _AlignmentBoxState();
}

class _AlignmentBoxState extends State<AlignmentBox> {
  Alignment alignment = Alignment.center;

  Offset offset;

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.size.width / 2, widget.size.height / 2);
  }

  void _updateAlignment() {
    var x = offset.dx / widget.size.width;
    var y = offset.dy / widget.size.height;

    // translate 0 - 1 to (-1) - 1
    var scaledX = x * 2 - 1;
    var scaledY = y * 2 - 1;

    Offset cappedOffset = _capOffset(minX: -1, maxX: 1, minY: -1, maxY: 1, offset: Offset(scaledX, scaledY));
    if (widget.onUpdate != null) {
      // Cap the offset, even though this is allowed in Flutter, most of the times
      // it doesn't make sense.
      //
      // In the future there might be a way to remove this cap an visualize it neatly.
      // The problems were: Widget net being able to be dragged when outside of the align
      widget.onUpdate(Alignment(cappedOffset.dx, cappedOffset.dy));
    }
    alignment = Alignment(cappedOffset.dy, cappedOffset.dy);
  }

  void onPanUpdate(DragUpdateDetails details) {
    var delta = details.delta;

    offset += delta;
    _updateAlignment();
    setState(() {});
  }

  void onPanStart(DragStartDetails details) {
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(details.globalPosition);

    offset = local;
    _updateAlignment();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
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
        ),
        Spacer(),
        NumericChangeableTextField(
          name: "X",
          value: alignment.x,
        ),
        SizedBox(width: 8,),
        NumericChangeableTextField(
          name: "Y",
          value: alignment.y,
          onUpdate: (it) {

          },
        ),
        Spacer(),
      ],
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
