
import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';


class NetworkImageComponent extends VisualStatefulWidget {

  NetworkImageComponent({
    String id,
    Map<String, Property> properties,
    Map<String, WidgetProperty> widgetProperties
  }) : super(id: id, key: GlobalObjectKey<VisualState>(id), properties: properties ?? const {}, widgetProperties: widgetProperties?? const {});

  @override
  _NetworkImageComponentState  createState() => _NetworkImageComponentState();

  @override
  String get originalClassName => "NetworkImage";
}

class _NetworkImageComponentState extends VisualState<NetworkImageComponent> {

  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();
  @override
  Widget buildWidget(BuildContext context) {
    return Image.network(getValue('src'));
  }

  @override
  // TODO implement
  Map<String, WidgetProperty> get modifiedWidgetProperties => {

  };

  @override
  // TODO implement
  Map<String, Property> initRemoteValues() => {
    'src': StringProperty("https://images.unsplash.com/photo-1548783300-70b41bc84f56?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1868&q=80.jpg"),
  };
}