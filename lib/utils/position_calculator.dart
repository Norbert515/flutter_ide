import '../material.dart';

class PositionedObject {
  final Offset position;
  final Size size;

  const PositionedObject({this.position, this.size});
}

// TODO make abstract and add different ways to calculate the position

class PositionCalculator {

  Offset getPosition(List<PositionedObject> objects, Size newSize) {

    if(objects.isEmpty) {
      return Offset.zero;
    }

    var maxX = double.negativeInfinity;
    var widthOfMax = 0.0;

    objects.forEach((it) {
      if(it.position.dx > maxX)
        maxX = it.position.dx;
        widthOfMax = it.size.width;
    });

    return Offset(maxX + widthOfMax + 16, 16);
  }

}