

import 'package:flutter/material.dart';

class FirstBuildFocus extends StatefulWidget {

  final FocusNode focusNode;
  final Widget child;

  const FirstBuildFocus({Key key, @required this.focusNode, this.child}) : super(key: key);
  @override
  _FirstBuildFocusState createState() => _FirstBuildFocusState();
}

class _FirstBuildFocusState extends State<FirstBuildFocus> {

  bool alreadyBuilt = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(!alreadyBuilt) {
      FocusScope.of(context).requestFocus(widget.focusNode);
      alreadyBuilt = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
