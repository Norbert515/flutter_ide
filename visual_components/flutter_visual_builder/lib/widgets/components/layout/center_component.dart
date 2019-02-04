import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';


class CenterComponent extends VisualStatefulWidget {

  CenterComponent({
    String id,
    Map<String, Property> properties,
    Map<String, WidgetProperty> widgetProperties,
    this.child,
  }) : super(id: id, key: GlobalObjectKey<VisualState>(id), properties: properties ?? const {}, widgetProperties: widgetProperties?? const {});

  final Widget child;

  @override
  _CenterComponentState  createState() => _CenterComponentState();

  @override
  String get originalClassName => "Center";
}

class _CenterComponentState extends VisualState<CenterComponent> {

  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: LayoutDragTarget(child: widget.child, key: childKey),
    );
  }

  @override
  // TODO implement
  Map<String, WidgetProperty> get modifiedWidgetProperties => {
    'child': WidgetProperty.keyed(childKey),
  };

  @override
  // TODO implement
  Map<String, Property> initRemoteValues() => {

  };
}