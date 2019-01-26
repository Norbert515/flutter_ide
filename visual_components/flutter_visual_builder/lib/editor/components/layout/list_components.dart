import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/properties/enum_properties.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';

mixin _ListComponentMixin<T extends VisualStatefulWidget> on VisualState<T> {

  List<GlobalKey<VisualState>> keys = [GlobalKey()];


  List<Widget> _getChildren() {
    if(keys.length == 1)
      return [_getTargetWidget(keys[0], first: true)];

    return keys.map((it) {
      return _getTargetWidget(it);
    }).toList();
  }



  Widget _getTargetWidget(GlobalKey<VisualState> key, {bool first = false}) {
    Widget result =  LayoutDragTarget(
        onLeave: () {
          if(!keys.contains(key)) return;
          setState(() {
            int index = keys.indexOf(key);
            keys.removeAt(index);
            keys.removeAt(index - 1);
          });
        },
        onAccept: () {
          setState(() {
            int index = keys.indexOf(key);
            keys.insert(index + 1 , GlobalKey());
            keys.insert(index, GlobalKey());
          });
        },
        key: key,
        replacementActive: Placeholder(
          color: Colors.green,
          fallbackHeight: 20,
        ),
        replacementInactive: Placeholder(
          color: Colors.blue,
          fallbackHeight: 20,
        ),
        child: null
    );

    if(first) {
      return SizedBox(
        height: 40,
        child: result,
      );
    }
    return result;
  }

}

class VisualColumn extends VisualStatefulWidget {

  VisualColumn({
    String id,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    Map<String, Property> properties,
    List<WidgetProperty> widgetProperties,
}): super(id: id, key: GlobalObjectKey<VisualState>(id), properties: properties?? const {}, widgetProperties: widgetProperties ?? const [] );

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;
  final List<Widget> children;

  @override
  _VisualColumnState createState() => _VisualColumnState();

  @override
  String get originalClassName => "Column";
}

class _VisualColumnState extends VisualState<VisualColumn> with _ListComponentMixin{


  @override
  List<WidgetProperty> get modifiedWidgetProperties => null;



  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: getValue('mainAxisAlignment'),
      textDirection: widget.textDirection,
      crossAxisAlignment: getValue('crossAxisAlignment'),
      mainAxisSize: widget.mainAxisSize,
      verticalDirection: widget.verticalDirection,
      textBaseline: widget.textBaseline,
      children: _getChildren(),
    );
  }

  @override
  Map<String, Property> initRemoteValues() => {
    'mainAxisAlignment': MainAxisAlignmentProperty(widget.mainAxisAlignment),
    'crossAxisAlignment': CrossAxisAlignmentProperty(widget.crossAxisAlignment),
  };

}