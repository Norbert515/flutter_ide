import 'package:flutter/material.dart';

import '../../../../generated/&gen_code.dart';

class WidgetVisualizer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return $displayWidget() ?? SizedBox(child: Text("Nothing to show"),);
  }
}
