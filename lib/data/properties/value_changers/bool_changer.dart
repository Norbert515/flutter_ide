import 'package:widget_maker_2_0/data/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/material.dart';

class BoolChanger extends StatelessValueChanger<bool> {
  BoolChanger({Key key, bool value, ValueChanged<bool> onUpdate, @required bool nullable})
      : super(key: key, value: value, onUpdate: onUpdate, nullable: nullable);


  @override
  Widget build(BuildContext context) {
    return Checkbox(
      tristate: nullable,
      value: value,
      onChanged: onUpdate,
    );
  }
}
