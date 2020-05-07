import 'package:widget_maker_2_0/material.dart';

class MyTheme extends StatelessWidget {

  const MyTheme({Key key, this.myThemeData, this.child}) : super(key: key);

  final MyThemeData myThemeData;

  final Widget child;


  static MyThemeData of(BuildContext context) {
    final _MyInheritedTheme myInheritedTheme = context.inheritFromWidgetOfExactType(_MyInheritedTheme);

    return myInheritedTheme.myTheme.myThemeData;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: myThemeData.themeData,
      child: _MyInheritedTheme(
        myTheme: this,
        child: child,
      ),
    );
  }
}


class _MyInheritedTheme extends InheritedWidget {


  final Widget child;
  final MyTheme myTheme;

  const _MyInheritedTheme({this.child, this.myTheme}): super(child: child);

  @override
  bool updateShouldNotify(_MyInheritedTheme oldWidget) => myTheme.myThemeData != oldWidget.myTheme.myThemeData;

}


class MyThemeData {



  factory MyThemeData({ThemeData themeData}) {


    var bg = themeData.backgroundColor;

    return MyThemeData._(
      themeData: themeData,
      background0dp: bg,
      background1dp: alphaBlendWithWhite(bg, 5),
      background2dp: alphaBlendWithWhite(bg, 7),
      background3dp: alphaBlendWithWhite(bg, 8),
      background4dp: alphaBlendWithWhite(bg, 9),
      background6dp: alphaBlendWithWhite(bg, 11),
      background8dp: alphaBlendWithWhite(bg, 12),
      background12dp: alphaBlendWithWhite(bg, 14),
      background16dp: alphaBlendWithWhite(bg, 15),
      background24dp: alphaBlendWithWhite(bg, 16),
      selectedColor: Colors.indigo,
    );
  }



  static Color alphaBlendWithWhite(Color background, double alphaInPercentage) => alphaBlend(background, Colors.white, alphaInPercentage / 100);
  static Color alphaBlend(Color background, Color foreground, double alpha) {
    assert(alpha >= 0 && alpha <= 1);

    var r3 = (background.red + (foreground.red - background.red) * alpha).round();
    var g3 = (background.green + (foreground.green - background.green) * alpha).round();
    var b3 = (background.blue + (foreground.blue - background.blue) * alpha).round();

    return Color.fromRGBO(r3, g3, b3, 1);
  }

  MyThemeData._({
    this.background0dp,
    this.background1dp,
    this.background2dp,
    this.background3dp,
    this.background4dp,
    this.background6dp,
    this.background8dp,
    this.background12dp,
    this.background16dp,
    this.background24dp,
    this.themeData,
    this.selectedColor
  });

  final ThemeData themeData;


  final Color background0dp;
  final Color background1dp;
  final Color background2dp;
  final Color background3dp;
  final Color background4dp;
  final Color background6dp;
  final Color background8dp;
  final Color background12dp;
  final Color background16dp;
  final Color background24dp;

  final Color selectedColor;
}