import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/modules/theme.dart';
import 'configuration_bar.dart';

class RightBar extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: MyTheme.of(context).background4dp,
      width: 350,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(child: ConfigurationBar()),
        ],
      ),
    );
  }
}
