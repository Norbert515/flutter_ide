import 'package:widget_maker_2_0/data/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/widgets/number_changer.dart';
import 'package:widget_maker_2_0/material.dart';


class ConstraintsChanger extends StatelessValueChanger<BoxConstraints>{

  ConstraintsChanger({Key key, BoxConstraints constraints, ValueChanged<BoxConstraints> onUpdate}) :
        super(key: key, value: constraints, onUpdate: onUpdate);

  void _update({double minWidth, double maxWidth, double minHeight, double maxHeight}) {
    var oldConstraints;
    if(value == null) {
      oldConstraints = BoxConstraints();
    } else {
      oldConstraints = value;
    }

    var newConstraints = oldConstraints.copyWith(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );

    onUpdate(newConstraints);
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            NumberChanger(
              allowNegative: false,
              onUpdate: (it) {
                _update(minWidth: it);
              },
              value: value?.minWidth?? 0,
              name: "minWidth",
            ),
            NumberChanger(
              allowNegative: false,
              onUpdate: (it) {
                _update(maxWidth: it);
              },
              value: value?.maxWidth?? 0,
              name: "maxWidth",
            ),
          ],
        ),
        Column(
          children: <Widget>[
            NumberChanger(
              allowNegative: false,
              onUpdate: (it) {
                _update(minHeight: it);
              },
              value: value?.minHeight?? 0,
              name: "minHeight",
            ),
            NumberChanger(
              allowNegative: false,
              onUpdate: (it) {
                _update(maxHeight: it);
              },
              value: value?.maxHeight?? 0,
              name: "maxHeight",
            ),
          ],
        ),
      ],
    );
  }
}
