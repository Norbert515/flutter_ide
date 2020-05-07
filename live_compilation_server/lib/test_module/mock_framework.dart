

class State {
  const State();
}
abstract class Widget {

}

abstract class StatelessWidget extends Widget{

  Widget build(BuildContext context);

}

class Container extends Widget {

  Container({this.child, this.width, this.height});

  final Widget child;
  final DoubleObject width;
  final DoubleObject height;

}

class BuildContext {

}

class DoubleObject {

  DoubleObject({this.name, this.value});

  final String name;
  final double value;

}