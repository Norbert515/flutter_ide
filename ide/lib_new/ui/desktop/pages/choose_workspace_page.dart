import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/material.dart';

import '../../../data/blocs/project_bloc.dart';

class ChooseWorkspacePage extends StatelessWidget {

  void selectFolder(BuildContext context, String path) {
    ProjectBloc.of(context).setProject(path);
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
          Expanded(
            child: Material(
              elevation: 8,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 400,
                  maxWidth: 800,
                ),
                child: FilePicker(
                  onPathSelected: (it) => selectFolder(context, it),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
