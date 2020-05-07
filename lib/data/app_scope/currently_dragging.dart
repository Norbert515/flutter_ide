import 'package:widget_maker_2_0/material.dart';
import 'package:provider/provider.dart';

class CurrentlyDragging extends StatefulWidget {


  final Widget child;

  const CurrentlyDragging({Key key, this.child}) : super(key: key);

  @override
  CurrentlyDraggingState createState() => CurrentlyDraggingState();
}

class CurrentlyDraggingState extends State<CurrentlyDragging> {


  bool _isDragging = false;
  bool get isDragging => _isDragging;

  void setDragging(bool dragging) {
    setState(() {
      _isDragging = dragging;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Provider<CurrentlyDraggingState>.value(
      value: this,
      child: widget.child,
      updateShouldNotify: (one, two) => true,
    );
  }
}
