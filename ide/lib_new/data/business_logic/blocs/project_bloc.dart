import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../model/flutter_project.dart';




/// Bloc responsible to handle common data flow in a project.
///
/// Common project state, such as open files are handled by this.
class ProjectBloc {

  // Todo remove reference to context from logic classes
  static ProjectBloc of(BuildContext context) {
    return Provider.of<ProjectBloc>(context);
  }

  /// Has a path to the open file
  BehaviorSubject<String> openFileSubject = BehaviorSubject();

  FlutterProject project;


  void setProject(String path) {
    project = LocalFlutterProject(rootFolder: Directory(path));
  }


  void dispose() {
    openFileSubject.close();
  }

}

