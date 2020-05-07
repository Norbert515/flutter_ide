import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_maker_2_0/data/app_scope/project.dart';
import 'package:widget_maker_2_0/data/app_scope/currently_dragging.dart';

/// A widget which contains all dependencies which should be accessible
/// throughout the entire app life cycle.
class AppScope extends StatefulWidget {

  final Widget child;

  /// This is for debugging purposes
  ///
  /// When in debug mode, you can access this via a static accessor.
  static Project debugProject;

  /// Only use this in debug mode
  static String resolveDebugId(String id) {
    return debugProject.widgetBoard.getWidgetElementFromAnySource(id)?.name ?? "No idea";
  }

  const AppScope({Key key, this.child}) : super(key: key);

  static Project of(BuildContext context, {listen: true}) {
    return Provider.of<Project>(context, listen: listen);
  }

  @override
  _AppScopeState createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {

  Project project;

  @override
  void initState() {
    super.initState();
    project = Project();

    print("Initing");
    assert((){
      AppScope.debugProject = project;

      return true;
    }());
    project.addListener(update);
  }

  void update() {
    setState((){});
  }

  @override
  void dispose() {
    project.removeListener(update);
    project.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CurrentlyDragging(
      child: Provider<Project>.value(
        value: project,
        child: widget.child,
        updateShouldNotify: (old, n) => true,
      ),
    );
  }
}

