import 'package:widget_maker_2_0/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:widget_maker_2_0/ui/theme.dart';

class DartCode extends StatelessWidget {

  final String code;

  const DartCode({Key key, this.code}) : super(key: key);


  Map<String, TextStyle> getTheme(BuildContext context) {
    var map = themeMap['darcula'];
    var root = map['root'];
    var newRoot = root.copyWith(backgroundColor: MyTheme.of(context).background16dp);
    map['root'] = newRoot;
    return map;
  }
  @override
  Widget build(BuildContext context) {
    return HighlightView(
      code,
      language: 'dart',
      theme: themeMap['darcula'],
      padding: const EdgeInsets.all(12),
      textStyle: TextStyle(
        fontFamily: "SourceCodePro",
        fontSize: 12,
        //backgroundColor: MyTheme.of(context).background16dp
      ),
    );
  }
}
