import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/TextField.dart';
import 'package:widget_maker_2_0/widget_elements/widgets/base.dart';

class TextFieldElementWidget extends StatefulWidget with ElementWidgetMixin {
  TextFieldElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _TextFieldElementWidgetState createState() => _TextFieldElementWidgetState();
}

class _TextFieldElementWidgetState extends State<TextFieldElementWidget> with ElementWidgetStateMixin<TextFieldElement, TextFieldElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: AbsorbPointer(
          absorbing: playMode? false: true,
          child: TextField(
            obscureText: element.obscureText.value,
          ),
        )
    );
  }

}


