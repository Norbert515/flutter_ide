import 'package:flutter/material.dart';

import 'enum_changer.dart';


enum _DecorationType {
  BoxDecoration,
  FlutterLogoDecoration,
  ShapeDecoration,
  Unknown,
}
class DecorationChanger extends StatefulWidget {

  final ValueChanged<Decoration> onChange;
  final Decoration value;
  final String name;

  const DecorationChanger({Key key, this.onChange, this.value, this.name}) : super(key: key);

  @override
  _DecorationChangerState createState() => _DecorationChangerState();
}

class _DecorationChangerState extends State<DecorationChanger> {


  _DecorationType get decorationType {
    if(widget.value == null) return null;
    if(widget.value is BoxDecoration) {
      return _DecorationType.BoxDecoration;
    } else if(widget.value is FlutterLogoDecoration) {
      return _DecorationType.FlutterLogoDecoration;
    } else if(widget.value is ShapeDecoration) {
      return _DecorationType.ShapeDecoration;
    }
    return _DecorationType.Unknown;
  }

  void _onDecorationUpdate(_DecorationType type) {
    if(type == decorationType) return;
    switch(type) {
      case _DecorationType.BoxDecoration:
        widget.onChange(BoxDecoration());
        break;
      case _DecorationType.FlutterLogoDecoration:
        widget.onChange(FlutterLogoDecoration());
        break;
      case _DecorationType.ShapeDecoration:
        widget.onChange(ShapeDecoration(shape: null));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EnumChanger<_DecorationType>(
      value: decorationType,
      possibleValues: _DecorationType.values,
      onUpdate: _onDecorationUpdate,
    );
  }
}

