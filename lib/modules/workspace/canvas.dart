

import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/properties/meta_properties.dart';

/// A canvas is an object which lies on the infinite board
///
/// It represents either a Stateful or Stateless Widget, it contains other widgets.
///
/// Widgets can be moved freely across canvases.
///
/// Canvases can be instantiated in other canvases
///
class Canvas {

  Canvas({
    @required this.id,
    @required this.wrapperId
  });

  /// This id of this canvas, must be unique
  final String id;

  /// The id of the wrapper element.
  final String wrapperId;

  Offset position;
  CanvasSize size;



}