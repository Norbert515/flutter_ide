

import 'package:flutter/material.dart';

class WIPTextEditor extends StatelessWidget {

  const WIPTextEditor({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(text),
    );
  }
}
