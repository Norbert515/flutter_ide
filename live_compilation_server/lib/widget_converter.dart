import 'package:flutter/material.dart';
//import 'package:widget_converter/converter.dart';



Map convertWidget(Widget widget) {
  if(widget == null) return null;
  switch(widget.runtimeType) {
    case Container:
      return convertContainer(widget);
    case Text:
      return convertText(widget);
    case Center:
      return convertCenter(widget);
    case Scaffold:
      return convertScaffold(widget);
    case AppBar:
      return convertAppBar(widget);
    case FloatingActionButton:
      return convertFloatingActionButton(widget);
  }
}



Map convertContainer(Container container) {
  return {
    "type": "Container",
    "child": convertWidget(container?.child),
  };
}

Map convertText(Text text) {
  return {
    "type": "Text",
    "text": text?.data,
    //"style": textStyleToMap(text?.style)
  };
}

Map convertCenter(Center center) {
  return {
    "type": "Center",
    "child": convertWidget(center?.child),
  };
}

Map convertScaffold(Scaffold scaffold) {
  return {
    "type": "Scaffold",
    "appBar": convertWidget(scaffold?.appBar),
    "body": convertWidget(scaffold?.body),
    "floatingActionButton": convertWidget(scaffold?.floatingActionButton)
  };
}

Map convertAppBar(AppBar appBar) {
  return {
    "type": "AppBar",
    "title": convertWidget(appBar?.title)
  };
}


Map convertFloatingActionButton(FloatingActionButton floatingActionButton) {
  return {
    "type": "FloatingActionButton",
    "child": convertWidget(floatingActionButton?.child),
  };
}