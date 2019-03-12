
import 'package:flutter/material.dart';

class MinimalTextEditor extends StatefulWidget {

  const MinimalTextEditor({Key key, this.text}) : super(key: key);

  /// The initial text
  final String text;

  @override
  MinimalTextEditorState createState() {
    return MinimalTextEditorState();
  }
}

class MinimalTextEditorState extends State<MinimalTextEditor> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 800,
      color: Colors.grey,
      child: TextField(
        controller: _controller,
      ),
    );
  }


}
