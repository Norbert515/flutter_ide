


import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';

KeyResolver keyResolver = KeyResolver();

class KeyResolver {

  // TODO subclass State with VIsualState and replace second with GlobalKey

  /// A map which contains the mapping from an id to an actual widget.
  ///
  /// This is used when generating source code (so the parent can find its
  /// children) and the server used this to update specific widgets.
  Map<String, GlobalKey<VisualState>> map = {};

}