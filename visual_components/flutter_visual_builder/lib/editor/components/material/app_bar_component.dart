import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';


class AppBarComponent extends VisualStatefulWidget implements PreferredSizeWidget {

  AppBarComponent({
    String id,
    Map<String, Property> properties,
    Map<String, WidgetProperty> widgetProperties,
    this.leading,
    this.automaticallyImplyLeading,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.primary,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarOpacity,
    this.bottomOpacity,
  }) : preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(id: id, key: GlobalKey<VisualState>(), properties: properties ?? const {}, widgetProperties: widgetProperties?? const {});


  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final Color backgroundColor;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  @override
  final Size preferredSize;

  @override
  _AppBarComponentState  createState() => _AppBarComponentState();

  @override
  String get originalClassName => "AppBar";
}

class _AppBarComponentState extends VisualState<AppBarComponent> {

  final GlobalKey<LayoutDragTargetState> leading = GlobalKey();
  final GlobalKey<LayoutDragTargetState> title = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return AppBar(
      backgroundColor: getValue('backgroundColor'),
      centerTitle: getValue('centerTitle'),
      title: LayoutDragTarget(
        key: title,
        child: widget.title,
      ),
      leading: LayoutDragTarget(
        key: leading,
        child: widget.leading,
      ),
      elevation: getValue('elevation'),
    );
  }

  @override
  // TODO implement
  Map<String, WidgetProperty> get modifiedWidgetProperties => {
    'leading': WidgetProperty.keyed(leading),
    'title': WidgetProperty.keyed(title),
  };

  @override
  // TODO implement
  Map<String, Property> initRemoteValues() => {
    'backgroundColor': ColorProperty(color: widget.backgroundColor),
    'centerTitle': BoolProperty(widget.centerTitle),
    'elevation': DoubleProperty(data: widget.elevation)
  };
}