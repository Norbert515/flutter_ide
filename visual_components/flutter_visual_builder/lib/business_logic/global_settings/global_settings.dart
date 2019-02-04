
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceholderManager extends StatefulWidget {


  const PlaceholderManager({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  PlaceholderManagerState createState() => PlaceholderManagerState();
}
// TODO change to custom inhertied width because bools might exists multiple times
class PlaceholderManagerState extends State<PlaceholderManager> {

  bool showing = true;


  void setShowing(bool showing) {
    print("setting to $showing");
    setState(() {
      this.showing = showing;
    });
  }

  static PlaceholderManagerState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<PlaceholderManagerState>());
  }


  @override
  Widget build(BuildContext context) {
    return Provider<bool>(
      child: widget.child,
      value: showing,
    );
  }
}
