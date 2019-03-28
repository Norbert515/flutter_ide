import 'dart:io';

import 'package:flutter/material.dart';
import 'package:text_editor/src/syntax_highlighter.dart';

class CodeShowcase extends StatelessWidget {

  CodeShowcase({Key key, this.sourceCode}) : super(key: key);

  final String sourceCode;

  final DartSyntaxHighlighter highlighter = DartSyntaxHighlighter(SyntaxHighlighterStyle.customThemeStyle());


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Theme.of(context).accentColor,
          child: Row(
            children: <Widget>[
              Text("This widget is executable!"),
              Spacer(),
              MaterialButton(
                onPressed: () {
                  
                },
                child: Text("Execute"),
              ),
            ],
          ),
        ),
        RichText(
          text: highlighter.format(sourceCode),
        ),
      ],
    );
  }
}

class CodeShowcaseFile extends StatefulWidget {

  const CodeShowcaseFile({Key key, this.pathToFile}) : super(key: key);

  final String pathToFile;

  @override
  _CodeShowcaseFileState createState() => _CodeShowcaseFileState();
}

class _CodeShowcaseFileState extends State<CodeShowcaseFile> {


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
        return CodeShowcase(
          sourceCode: snapshot.requireData,
        );
      },
    );
  }
}
