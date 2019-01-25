


import 'package:flutter/material.dart';
import 'package:ide/themeing/ide_theme.dart';

class PaletteCategory extends StatelessWidget {

  const PaletteCategory({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: 50,
        color: IDETheme.of(context).widgetSelectorTheme.sectionBackgroundColor,
        child: Row(
          children: <Widget>[
            Icon(Icons.folder, color: IDETheme.of(context).widgetSelectorTheme.iconColor,),
            SizedBox(width: 4,),
            Text(title, style: IDETheme.of(context).widgetSelectorTheme.sectionTextItem),
            Spacer(),
          ],
        ),
      ),
    );
  }
}


class PaletteItem extends StatelessWidget {

  const PaletteItem({Key key, this.icon, this.name}) : super(key: key);

  final Widget icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            IconTheme(
              data: IconThemeData(color: IDETheme.of(context).widgetSelectorTheme.iconColor),
              child: icon,
            ),
            SizedBox(width: 4,),
            Text(name, style: IDETheme.of(context).widgetSelectorTheme.widgetTextItem,),
          ],
        ),
      ),
    );
  }
}
