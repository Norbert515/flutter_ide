


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../model/flutter_project.dart';

class ProjectBloc {

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

