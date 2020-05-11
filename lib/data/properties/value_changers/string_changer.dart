import 'package:widget_maker_2_0/data/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/material.dart';

class StringChanger extends StatefulValueChanger<String> {


  StringChanger({Key key, String value, ValueChanged<String> onUpdate, bool nullable})
    : super(key: key, value: value, onUpdate: onUpdate, nullable: nullable);



  @override
  State<StatefulWidget> createState() => _StringChangerState();

}
class _StringChangerState extends State<StringChanger> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value;
  }

  @override
  void didUpdateWidget(StringChanger oldWidget) {
    super.didUpdateWidget(oldWidget);
    //controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: IntrinsicHeight(
        child: TextField(
          maxLines: null,
          style: Theme.of(context).textTheme.body1,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder()
          ),
          onChanged: widget.onUpdate,
          controller: controller,
        ),
      ),
    );
  }


}

class AutoFocusTextField extends StatefulWidget {


  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextStyle style;
  final int maxLines;
  final InputDecoration decoration;

  const AutoFocusTextField({Key key, this.onChanged, this.controller, this.style, this.maxLines, this.decoration}) : super(key: key);

  @override
  _AutoFocusTextFieldState createState() => _AutoFocusTextFieldState();
}

class _AutoFocusTextFieldState extends State<AutoFocusTextField> {

  FocusNode node;
  bool alreadyRequestedFocus = false;

  @override
  void initState() {
    super.initState();
    node = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!alreadyRequestedFocus) {
      FocusScope.of(context).requestFocus(node);
      alreadyRequestedFocus = true;
    }
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: node,
      maxLines: widget.maxLines,
      style: widget.style,
      decoration: widget.decoration,
      onChanged: widget.onChanged,
      controller: widget.controller,
    );
  }
}
