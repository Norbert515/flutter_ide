import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// TODO maybe move this into a separate package so the visual builder and the IDE can both depend on it

class IDETheme {



  static IDETheme of(BuildContext context) {
    return Provider.of<IDETheme>(context);
  }

  IDETheme({
    this.darkBackground,
    this.darkerBackground,
    this.lightBackground,
    this.textEditorTheme,
    this.propertyChangerTheme,
});

  factory IDETheme.standard() {


    final Color darkBackground = Color(0xff1d1d1d);
    final Color darkerBackground = Color(0xff1f1f1f);
    final Color lightBackground = Color(0xff313131);

    Color fontColor = Colors.white;


    final TextEditorTheme textEditorTheme = TextEditorTheme(
      text: TextStyle(color: fontColor)
    );

    // TODO use default text theme instead of wrapping each in a color?
    final PropertyChangerTheme propertyChangerTheme = PropertyChangerTheme(
      widgetName: TextStyle(fontSize: 25, color: fontColor),
      widgetId: TextStyle(color: fontColor),
      propertyContainer: TextStyle(color: fontColor),
      propertyName: TextStyle(color: fontColor),
      propertyNumericValue: TextStyle(color: fontColor)
    );


    // TODO implement all the themes
    return IDETheme(
      darkBackground: darkBackground,
      darkerBackground: darkerBackground,
      lightBackground: lightBackground,
      textEditorTheme: textEditorTheme,
      propertyChangerTheme: propertyChangerTheme
    );
  }

 // final TextStyle head;

  final Color darkBackground;
  final Color darkerBackground;
  final Color lightBackground;

  final TextEditorTheme textEditorTheme;

  final PropertyChangerTheme propertyChangerTheme;


}


class TextEditorTheme {


  TextEditorTheme({this.text});

  final TextStyle text;
}

class PropertyChangerTheme {


  PropertyChangerTheme({
    this.widgetName,
    this.widgetId,
    this.propertyContainer,
    this.propertyName,
    this.propertyNumericValue,
  });



  final TextStyle widgetName;
  final TextStyle widgetId;

  /// Would be "size" for x/y
  final TextStyle propertyContainer;
  final TextStyle propertyName;
  final TextStyle propertyNumericValue;


}