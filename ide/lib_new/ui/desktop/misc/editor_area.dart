
import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

import '../../../data/services/widget_extractor.dart';

class EditorArea extends StatefulWidget {



  const EditorArea({Key key, this.sourceCode}) : super(key: key);

  final String sourceCode;

  @override
  EditorAreaState createState() {
    return EditorAreaState();
  }
}

class EditorAreaState extends State<EditorArea> {


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
                textColor: Theme.of(context).textTheme.body1.color,
                onPressed: () {
                  WidgetExtractor extractor = WidgetExtractor(widget.sourceCode);
                  extractor.extractWidget();
                },
                child: Text("Execute"),
              ),
            ],
          ),
        ),
        CodeShowcase(sourceCode: widget.sourceCode,),
      ],
    );
  }
}
