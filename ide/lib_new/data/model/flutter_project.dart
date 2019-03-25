import 'dart:io';

import 'package:meta/meta.dart';

abstract class FlutterProject {

  bool get hasPubspec;

  bool get hasIosProject;
  bool get hasAndroidProject;
  bool get hasLibFolder;
  bool get hasTestFolder;


  bool get isValid => hasPubspec && hasIosProject && hasAndroidProject && hasLibFolder;


  File get pubspec;

  Directory get getTestFolder;
  Directory getLibFolder;
}


class LocalFlutterProject extends FlutterProject {


  LocalFlutterProject({
    @required this.rootDirectory
  });

  final Directory rootDirectory;


  @override
  Directory get getTestFolder => null;

  @override
  bool get hasAndroidProject => null;

  @override
  // TODO: implement hasIosProject
  bool get hasIosProject => null;

  @override
  // TODO: implement hasLibFolder
  bool get hasLibFolder => null;

  @override
  // TODO: implement hasPubspec
  bool get hasPubspec => null;

  @override
  // TODO: implement hasTestFolder
  bool get hasTestFolder => null;

  @override
  // TODO: implement pubspec
  File get pubspec => null;

}