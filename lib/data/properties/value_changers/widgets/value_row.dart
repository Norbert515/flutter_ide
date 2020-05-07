import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';

class PropertyVariableSelector extends StatelessWidget {

  const PropertyVariableSelector({Key key, this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(Icons.settings),
      ),
    );
  }
}


class PropertyText extends StatelessWidget {

  final String text;

  const PropertyText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 100, child: Text(MProperty.capitalize(text), style: TextStyle(
      fontSize: 16
    ),));
  }
}

class ValueRow extends StatelessWidget {

  final String text;
  final Widget child;
  final VoidCallback onVariableTap;

  const ValueRow({
    Key key,
    @required this.text,
    @required this.child,
    @required this.onVariableTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PropertyText(text: text),
          SizedBox(width: 16,),
          Expanded(child: child),
          PropertyVariableSelector(
            onTap: onVariableTap,
          ),
        ]
    );
  }
}
