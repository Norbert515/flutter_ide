


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectBloc {

  static ProjectBloc of(BuildContext context) {
    return Provider.of<ProjectBloc>(context);
  }

}

