

import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

class ProjectPage extends StatelessWidget {
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
                    onPathSelected: (_){},
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Material(
                    color: Theme.of(context).backgroundColor,
                    child: SingleChildScrollView(
                      child: CodeShowcase(
                        sourceCode: """
import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

class ProjectPage extends StatelessWidget {
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
                      onPathSelected: (_){},
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Material(
                      color: Theme.of(context).backgroundColor,
                      child: CodeShowcase(
                        sourceCode: """


                            """
                        ,
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
                        """
                        ,
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
