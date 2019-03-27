import 'package:flutter/material.dart';
import 'package:ide/pages/welcome.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

import 'data/blocs/project_bloc.dart';
import 'ui/desktop/choose_workspace_page.dart';
import 'ui/desktop/project_page.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  /// TODO move out routing for this class once it gets bigger
  /// Routing is interesting for an app which will run on desktop and mobile
  /// because mobile apps make have use of different pages but desktop doesn't.
  /// On desktop most of the things are one page which no "back navigation"
  ///
  /// Therefore the navigation will depending on the platform.
  /// The common_ui package contains all widget which will be reusable across
  /// desktop and mobile but each platform will have to implement a custom layout
  /// of those elements.

  /// Until there is a better solution for scoped model
  /// access, the state is going to be in here.
  final ProjectBloc projectBloc = ProjectBloc();


  @override
  Widget build(BuildContext context) {
    return Provider<ProjectBloc>(
      value: projectBloc,
      child: Provider<IDETheme>(
        value: IDETheme.standard(),
        updateShouldNotify: (it, i2) => false,
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Widget Maker',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: Color(0xff3c3f41),
            accentColor:  Color(0xff0d293e),
            iconTheme: IconThemeData(
              color: Color(0xffbbbbbb),
            ),
            textTheme: TextTheme(
              body1: TextStyle(color: Color(0xffbbbbbb), fontSize: 16),
            )
          ),
          routes: {
            '/welcome' : (context) => TutorialWelcome(),
            '/workspace': (context) => ProjectPage(),
          },
          onGenerateRoute: (settings) {

          } ,

          home: ChooseWorkspacePage(),
        ),
      ),
    );
  }
}


