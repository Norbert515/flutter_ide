

import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

import '../../data/blocs/project_bloc.dart';

class ProjectPage extends StatefulWidget {
  @override
  ProjectPageState createState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage> {


  ProjectBloc projectBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    projectBloc = ProjectBloc.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 32,
            child: Material(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Divider(),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: Material(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Divider(),
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: double.infinity,
                  width: 400,
                  child: FileSystemExplorer(
                    rootDirectory: projectBloc.project.rootFolder,
                    onPathSelected: (it){
                      projectBloc.openFileSubject.add(it);
                    },
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Material(
                    color: Theme.of(context).backgroundColor,
                    child: SingleChildScrollView(
                      child: StreamBuilder(
                        stream: projectBloc.openFileSubject,
                        builder: (context, snapshot) {
                          if(!snapshot.hasData) {
                            return Center(
                              child: Text("Open a file :)"),
                            );
                          }

                          return CodeShowcaseFile(
                            key: ValueKey(snapshot.requireData),
                            pathToFile: snapshot.requireData,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
