import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';


class RaisedButtonComponent extends VisualStatefulWidget {

  RaisedButtonComponent({
    String id,
    Map<String, Property> properties,
    Map<String, WidgetProperty> widgetProperties,
    this.child,
  }) : super(id: id, key: GlobalKey<VisualState>(), properties: properties ?? const {}, widgetProperties: widgetProperties?? const {});

  final Widget child;
  @override
  _RaisedButtonComponentState  createState() => _RaisedButtonComponentState();

  @override
  String get originalClassName => "RaisedButton";
}

class _RaisedButtonComponentState extends VisualState<RaisedButtonComponent> {

  final GlobalKey<LayoutDragTargetState> childKey = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        //TODO
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("You will be able to "
            "specify events later")));
      },
      child: LayoutDragTarget(
        child: widget.child,
        replacementInactive: SizedBox(height: 30, width: 50,child: InactivePlaceholder()),
        replacementActive: SizedBox(height: 30, width: 50, child: ActivePlaceholder()),
      ),
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