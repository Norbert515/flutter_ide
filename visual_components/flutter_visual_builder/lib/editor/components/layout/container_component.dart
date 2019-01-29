import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';

class VisualContainer extends VisualStatefulWidget {

  VisualContainer({
    String id,
    this.color,
    this.width,
    this.height,
    this.child,
    this.constraints,
    Map<String, Property> properties,
    Map<String, WidgetProperty> widgetProperties
  }) : super(id: id, key: GlobalKey<VisualState>(), properties: properties ?? const {}, widgetProperties: widgetProperties?? const {});

  final Widget child;
  final Color color;
  final double width;
  final double height;
  final BoxConstraints constraints;
  // TODO all properties


  @override
  _VisualContainerState createState() => _VisualContainerState();

  @override
  String get originalClassName => "Container";
}

class _VisualContainerState extends VisualState<VisualContainer> {


  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      child: LayoutDragTarget(
          key: childKey,
          child: widget.child
      ),
      color: getValue<Color>('color'),
      width: getValue<double>('width'),
      height: getValue<double>('height'),
      padding: getValue<EdgeInsets>('padding'),
      margin: getValue<EdgeInsets>('margin'),
      alignment: getValue<Alignment>('alignment'),
      constraints: getValue<BoxConstraints>('constraints'),
    );
  }

  @override
  Map<String, WidgetProperty> get modifiedWidgetProperties => {
    'child': WidgetProperty.keyed(childKey),
  };

  @override
  Map<String, Property> initRemoteValues() => {
    'color': ColorProperty(color: widget.color),
    'width': DoubleProperty(data: widget.width),
    'height': DoubleProperty(data: widget.height),
    'alignment': AlignmentProperty(alignment: Alignment.center),
    'padding': EdgeInsertsProperty(data: EdgeInsets.all(0)),
    'margin': EdgeInsertsProperty(data: EdgeInsets.all(0)),
    'constraints': BoxConstraintsProperty(data: BoxConstraints()),

  };
}