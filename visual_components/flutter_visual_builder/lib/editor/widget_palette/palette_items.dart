


import 'package:flutter/material.dart';

class PaletteCategory extends StatelessWidget {

  const PaletteCategory({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Icon(Icons.folder),
          Text(title),
          Spacer(),
        ],
      ),
    );
  }
}


class PaletteItem extends StatelessWidget {

  const PaletteItem({Key key, this.icon, this.name}) : super(key: key);

  final Widget icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
