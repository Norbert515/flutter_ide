

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaManipulator {


  // Todo remove reference to context from logic classes
  static MetaManipulator of(BuildContext context) {
    return Provider.of<MetaManipulator>(context);
  }

}