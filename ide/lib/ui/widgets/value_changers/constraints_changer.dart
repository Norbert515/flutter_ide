import 'package:flutter/material.dart';

class ChangeableConstraints extends StatelessWidget {
  const ChangeableConstraints(
      {Key key,
        this.onMinWidthChange,
        this.onMaxWidgetChange,
        this.onMinHeightChange,
        this.onMaxHeightChange})
      : super(key: key);

  final ValueChanged<double> onMinWidthChange;
  final ValueChanged<double> onMaxWidgetChange;
  final ValueChanged<double> onMinHeightChange;
  final ValueChanged<double> onMaxHeightChange;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}