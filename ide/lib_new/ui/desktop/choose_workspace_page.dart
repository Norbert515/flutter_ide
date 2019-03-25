import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/material.dart';

class ChooseWorkspacePage extends StatelessWidget {




  void selectFolder(BuildContext context, String path) {
    Navigator.pushNamed(context, "/workspace");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Check out the old demo while this is being worked on"),
            onPressed: () {
              Navigator.pushNamed(context, "/welcome");
            },
          ),
          Material(
            elevation: 8,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 400,
                maxWidth: 800,
                minHeight: 600,
                maxHeight: 1000,
              ),
              child: FileSystemExplorer(
                onPathSelected: (it) => selectFolder(context, it),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
