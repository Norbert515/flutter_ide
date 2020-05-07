import 'package:flutter/material.dart';

class $displayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuBar() ?? SizedBox();
  }
}

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("File"),
        Text("Edit"),
        Text("View"),
        Text("Navigate"),
        Text("Code"),
        Text("Analyze"),
        Text("Refactor"),
        Text("Build"),
        Text("Run"),
        Text("Tools"),
        Text("VCS"),
        Text("Window"),
        Text("Help"),
      ].map((it) => Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: it,)).toList(),
    );
  }
}
    
    