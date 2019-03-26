


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/flutter_project.dart';

class ProjectBloc {

  static ProjectBloc of(BuildContext context) {
    return Provider.of<ProjectBloc>(context);
  }


  FlutterProject project;

}

