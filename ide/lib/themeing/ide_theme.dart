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
    this.widgetSelectorTheme,
    this.fontColor,
});

  factory IDETheme.standard() {


    final Color darkBackground = Color(0xff1d1d1d);
    final Color darkerBackground = Color(0xff1f1f1f);
    final Color lightBackground = Color(0xff313131);

    Color fontColor = Colors.white.withOpacity(0.9);


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

    final WidgetSelectorTheme widgetSelectorTheme = WidgetSelectorTheme(
      iconColor: fontColor,
      sectionTextItem: TextStyle(color: fontColor),
      widgetTextItem: TextStyle(color: fontColor),
      sectionBackgroundColor: Colors.orange,
    );


    // TODO implement all the themes
    return IDETheme(
      darkBackground: darkBackground,
      darkerBackground: darkerBackground,
      lightBackground: lightBackground,
      fontColor: fontColor,
      textEditorTheme: textEditorTheme,
      propertyChangerTheme: propertyChangerTheme,
      widgetSelectorTheme: widgetSelectorTheme,
    );
  }

 // final TextStyle head;

  final Color darkBackground;
  final Color darkerBackground;
  final Color lightBackground;
  final Color fontColor;

  final TextEditorTheme textEditorTheme;

  final PropertyChangerTheme propertyChangerTheme;

  final WidgetSelectorTheme widgetSelectorTheme;


}

class WidgetSelectorTheme {

  WidgetSelectorTheme({this.iconColor, this.sectionTextItem, this.widgetTextItem, this.sectionBackgroundColor});

  final Color iconColor;
  final TextStyle sectionTextItem;
  final TextStyle widgetTextItem;

  final Color sectionBackgroundColor;
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