import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/material.dart';

class ChooseWorkspacePage extends StatelessWidget {




  void selectFolder(String path) {

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("Check out the old demo while this is being worked on"),
          onPressed: () {
            Navigator.pushNamed(context, "/welcome");
          },
        ),
        Container(
          constraints: BoxConstraints(
            minWidth: 400,
            maxWidth: 800,
            minHeight: 600,
            maxHeight: 1000,
          ),
          child: FileSystemExplorer(
            onPathSelected: selectFolder,
          ),
        ),
      ],
    );
  }
}
