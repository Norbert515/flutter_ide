import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/modules/theme.dart';
import 'package:widget_maker_2_0/properties/icon_property/m_icons.dart';
import 'package:widget_maker_2_0/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/properties/value_changers/widgets/changers.dart';

class IconDataChanger extends StatelessValueChanger<IconData> {

  IconDataChanger({Key key, IconData value, ValueChanged<IconData> onUpdate})
    : super(key: key, value: value, onUpdate: onUpdate);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: RoundContainer(
        child: InkWell(
          onTap: () async {
            var iconData = await showDialogAtContext(
              context: context,
              size: Size(240, 400),
              top: false,
              builder: (context) {
                return IconGrid();
              }
            );
            onUpdate(iconData);
          },
          child: Icon(value),
        ),
      ),
    );
  }
}

class IconGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GridView.count(
        crossAxisCount: 4,
        children: MIconContainer.all.map((it) {
          return Container(
            width: 60,
            height: 60,
            color: MyTheme.of(context).background24dp,
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Icon(it.icon),
                  Text(it.name,
                    style: TextStyle(
                      fontSize: 9,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pop(it.icon);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
