import 'dart:io';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:flutter/services.dart';
import 'package:widget_maker_2_0/modules/theme.dart';
import 'package:widget_maker_2_0/widgets/desktop_scroll_behavior.dart';

import 'modules/workspace/workspace_page/workspace_page.dart';


void main() {
  //Analytics ga = new AnalyticsIO("UA-133737406-2", 'widget_maker_app_2', '0.1',);

  //ga.sendEvent("navigation", "started");
  //ga.sendScreenView("viewName");
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var themeData = ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Color(0xff121212),
      brightness: Brightness.dark,
    );


    return ScrollConfiguration(
      behavior: DesktopBehavior(),
      child: CursorPositionWidget(
        child: AppScope(
          child: MyTheme(
            myThemeData: MyThemeData(
              themeData: themeData,
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: themeData,
              home: Builder(
                builder: (context) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 0.8,
                      devicePixelRatio: 11,
                    ),
                    child: WorkspacePage(),
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}

