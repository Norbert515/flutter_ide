import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

import '../../../data/business_logic/blocs/project_bloc.dart';
import '../misc/editor_area.dart';


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
              child: MenuBar(),
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
                  child: Align(
                    alignment: Alignment.topCenter,
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
                            return EditorAreaFile(
                              key: ValueKey(snapshot.requireData),
                              pathToFile: snapshot.requireData,
                            );

                          },
                        ),
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
