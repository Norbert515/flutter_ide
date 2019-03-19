
import 'package:flutter/material.dart';
import 'package:file_system_explorer/file_system_explorer.dart';

// TODO implement
class MenuBar extends StatefulWidget {

  const MenuBar({Key key, this.items}) : super(key: key);

  final List<MenuItem> items;

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return FileSystemExplorer();
              });
            },
          ),
        ],
      ),
    );
  }
}


class MenuItem extends StatefulWidget {
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
