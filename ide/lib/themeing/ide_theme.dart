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


    Color fontColor = Colors.white;


    // TODO implement all the themes
    return IDETheme(
      darkBackground: Color(0xff1d1d1d),
      darkerBackground: Color(0xff1f1f1f),
      lightBackground: Color(0xff313131),

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
    this.propertyName
  });



  final TextStyle widgetName;
  final TextStyle widgetId;

  /// Would be "size" for x/y
  final TextStyle propertyContainer;
  final TextStyle propertyName;


}