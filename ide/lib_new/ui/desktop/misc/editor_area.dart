import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

import '../../../data/business_logic/blocs/project_bloc.dart';
import '../../../data/services/source_code_reloader.dart';
import '../../../data/services/widget_extractor.dart';
import 'widget_visualizer.dart';


class EditorAreaFile extends StatefulWidget {

  const EditorAreaFile({Key key, this.pathToFile}) : super(key: key);

  final String pathToFile;

  @override
  _EditorAreaFileState createState() => _EditorAreaFileState();
}

class _EditorAreaFileState extends State<EditorAreaFile> {

  Future<String> file;

  @override
  void initState() {
    super.initState();
    file = File(widget.pathToFile).readAsString();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: file,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
        return EditorArea(
          sourceCode: snapshot.requireData,
        );
      },
    );
  }

}



class EditorArea extends StatefulWidget {
  const EditorArea({Key key, this.sourceCode}) : super(key: key);

  final String sourceCode;

  @override
  EditorAreaState createState() {
    return EditorAreaState();
  }
}

class EditorAreaState extends State<EditorArea> {

  bool canExecute;
  WidgetExtractor widgetExtractor = WidgetExtractor();
  SourceCodeReloader sourceCodeReloader = SourceCodeReloader();

  @override
  void initState() {
    super.initState();
    canExecute = widgetExtractor.isExecutable(widget.sourceCode);
  }

  @override
  Widget build(BuildContext context) {
    Widget topWidget = SizedBox();
    if (canExecute) {
      topWidget = Container(
        width: double.infinity,
        color: Theme.of(context).accentColor,
        child: Row(
          children: <Widget>[
            Text("This widget is executable!"),
            Spacer(),
            MaterialButton(
              textColor: Theme.of(context).textTheme.body1.color,
              onPressed: () async {
                await widgetExtractor.renderWidgetInIDE(widget.sourceCode);
                sourceCodeReloader.reloadSourceCode();
              },
              child: Text("Execute"),
            ),
          ],
        ),
      );
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              topWidget,
              CodeShowcase(
                sourceCode: widget.sourceCode,
              ),
            ],
          ),
        ),
        WidgetVisualizer(),
      ],
    );
  }
}
