import 'dart:math';
import 'package:widget_maker_2_0/data/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/widgets/number_changer.dart';
import 'package:widget_maker_2_0/material.dart';

enum EdgeInsetsMode {
  all, only, symmetrical, none
}


class EdgeInsetsChanger extends StatelessValueChanger<EdgeInsets>{

  EdgeInsetsChanger({Key key, this.mode, EdgeInsets edgeInsets, ValueChanged<EdgeInsets> onUpdate}) :
        super(key: key, value: edgeInsets, onUpdate: onUpdate);

  final EdgeInsetsMode mode;

  EdgeInsets get nValue => value ?? EdgeInsets.all(0);

  void _update({double left, double top, double right, double bottom}) {

    var oldInserts;
    if(value == null) {
      oldInserts = EdgeInsets.all(0);
    } else {
      oldInserts = value;
    }

    var newEdgeInsets = oldInserts.copyWith(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );

    onUpdate(newEdgeInsets);
  }

  Widget buildAll(context) {
    assert(nValue.left == nValue.right && nValue.top == nValue.bottom && nValue.top == nValue.right);
    return NumberChanger(
      allowNegative: false,
      onUpdate: (it) {
        _update(left: it, right: it, bottom: it, top: it);
      },
      value: value?.left ?? 0,
      showDescription: true,
      name: "All",
    );
  }

  Widget buildSymmetrical(context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: NumberChanger(
            allowNegative: false,
            onUpdate: (it) {
              _update(left: it, right: it);
            },
            value: value?.left ?? 0,
            name: "horizontal",
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: NumberChanger(
            allowNegative: false,
            onUpdate: (it) {
              _update(top: it, bottom: it);
            },
            value: value?.top?? 0,
            name: "vertical",
          ),
        ),
      ],
    );
  }

  Widget buildOnly(context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: NumberChanger(
            allowNegative: false,
            onUpdate: (it) {
              _update(left: it);
            },
            value: value?.left ?? 0,
            name: "left",
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: NumberChanger(
            allowNegative: false,
            onUpdate: (it) {
              _update(top: it);
            },
            value: value?.top?? 0,
            name: "top",
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: NumberChanger(
            allowNegative: false,
            onUpdate: (it) {
              _update(right: it);
            },
            value: value?.right?? 0,
            name: "right",
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: NumberChanger(
            allowNegative: false,
            onUpdate: (it) {
              _update(bottom: it);
            },
            value: value?.bottom?? 0,
            name: "bottom",
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    switch(mode) {
      case EdgeInsetsMode.all:
        return buildAll(context);
      case EdgeInsetsMode.symmetrical:
        return buildSymmetrical(context);
      case EdgeInsetsMode.only:
        return buildOnly(context);
      case EdgeInsetsMode.none:
        return SizedBox();
    }
    assert(false);
    return null;
  }
}
