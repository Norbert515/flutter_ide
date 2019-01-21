

import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/ui/home_page.dart';

class TextEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceCode>(
     stream: serverClient.serverClient.streamSourceCode(InitSourceCodeStream()),
      builder: (context, snapshot) {
       String source;
       if(!snapshot.hasData) {
         source = "";
       } else {
         source = snapshot.requireData.sourceCode;
       }
       return WIPTextEditor(
         text: source,
       );
      },
    );
  }
}

class WIPTextEditor extends StatelessWidget {

  const WIPTextEditor({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Text(text),
      ),
    );
  }
}
