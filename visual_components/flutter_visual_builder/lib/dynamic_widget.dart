import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';


// Representation of a widget which can be moved around the screen
class DynamicWidget {

  DynamicWidget(this.widget, this.sourceCode, {Widget feedback, this.child}) : this.feedback = feedback ?? widget;

  DynamicWidget.empty(): widget = null, sourceCode = null, feedback = null, child = null;

  DynamicWidget copyWith({VisualWidget visualWidget}) => DynamicWidget(this.widget, this.sourceCode, feedback: this.feedback, child: visualWidget);

  /// The widget which should be moved around
  ///
  /// This can contain two different things.
  ///
  /// 1. A normal Widget, something that does not accept any visual children itself.
  ///
  /// 2. A Visual child, like a FAB/ Scaffold/ Row etc.
  final VisualWidget widget;

  // The source code of this widget
  // TODO this should be calculated
  final String sourceCode;

  /// The representation of the widget while being dragged around.
  ///
  /// Useful when widgets would normally expand to infinity
  final Widget feedback;


  List<Property> properties;
  List<WidgetProperty> widgetProperties;

  String generateSourceCodeRecursive() {

  }

  /// The child of this dynamic widget.
  ///
  ///
  final VisualWidget child;
}

DynamicWidget testWidget = DynamicWidget(
    VisualWrapper(
      child: Container(
        color: Colors.green,
        width: 50,
        height: 100,
      ),
    ),
    'Container(color: Colors.green,width: 50,height: 100,)');

DynamicWidget testWidget2 = DynamicWidget(
    VisualFloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: (){},
    ),
    'FloatingActionButton(onPressed: (){}, backgroundColor: Colors.red,)', feedback: FloatingActionButton(onPressed: null, backgroundColor: Colors.red,));

DynamicWidget testWidget3 = DynamicWidget(
    VisualWrapper(child: Icon(Icons.add)),
    'Icon(Icons.add)');


