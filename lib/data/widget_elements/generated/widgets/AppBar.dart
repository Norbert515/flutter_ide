import 'package:widget_maker_2_0/data/properties/basic_properties.dart';
import 'package:widget_maker_2_0/data/properties/icon_property.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/base.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/enums.dart';
import 'package:widget_maker_2_0/data/properties/decoration_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/objects.dart';
import 'package:widget_maker_2_0/data/properties/wrappers/wrappers.dart';
import 'package:widget_maker_2_0/data/properties/enum_properties.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/wrappers/wrappers.dart';


class AppBarElement extends WidgetElement with SlotChildElementMixin {
  AppBarElement({
    @required String id,
    bool automaticallyImplyLeading,
    Color backgroundColor,
    Brightness brightness,
    double bottomOpacity,
    double toolbarOpacity,
    bool centerTitle,
    double titleSpacing,
    bool primary,
    double elevation,
  }) :
    automaticallyImplyLeading = MBoolProperty(
        value: automaticallyImplyLeading?? true,
        name: "automaticallyImplyLeading",
        defaultValue: true
    ),

    backgroundColor = MColorProperty(
        value: backgroundColor?? null,
        name: "backgroundColor",
        defaultValue: null
    ),

    brightness = MBrightnessProperty(
        value: brightness?? null,
        name: "brightness",
        defaultValue: null
    ),

    bottomOpacity = MDoubleProperty(
        value: bottomOpacity?? 1,
        name: "bottomOpacity",
        defaultValue: 1
    ),

    toolbarOpacity = MDoubleProperty(
        value: toolbarOpacity?? 1,
        name: "toolbarOpacity",
        defaultValue: 1
    ),

    centerTitle = MBoolProperty(
        value: centerTitle?? null,
        name: "centerTitle",
        defaultValue: null
    ),

    titleSpacing = MDoubleProperty(
        value: titleSpacing?? NavigationToolbar.kMiddleSpacing,
        name: "titleSpacing",
        defaultValue: NavigationToolbar.kMiddleSpacing
    ),

    primary = MBoolProperty(
        value: primary?? true,
        name: "primary",
        defaultValue: true
    ),

    elevation = MDoubleProperty(
        value: elevation?? null,
        name: "elevation",
        defaultValue: null
    ),


      super(id);

    final MBoolProperty automaticallyImplyLeading;
    final MColorProperty backgroundColor;
    final MBrightnessProperty brightness;
    final MDoubleProperty bottomOpacity;
    final MDoubleProperty toolbarOpacity;
    final MBoolProperty centerTitle;
    final MDoubleProperty titleSpacing;
    final MBoolProperty primary;
    final MDoubleProperty elevation;

    static const String TITLE = "title";
  static const String LEADING = "leading";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: TITLE),
   SingleChildSlot(slotName: LEADING),
  ];  
  
  @override
  List<MProperty> get attributes => [
    automaticallyImplyLeading,
    backgroundColor,
    brightness,
    bottomOpacity,
    toolbarOpacity,
    centerTitle,
    titleSpacing,
    primary,
    elevation,
  ];

  @override
  Widget generateWidget() {
    return AppBarElementWidget(
      id: id,
    );
  }

  factory AppBarElement.fromMap(Map<String, dynamic> map) {
    return AppBarElement(
        id: map["id"],
        automaticallyImplyLeading: map["automaticallyImplyLeading"],
        backgroundColor: map["backgroundColor"],
        brightness: map["brightness"],
        bottomOpacity: map["bottomOpacity"],
        toolbarOpacity: map["toolbarOpacity"],
        centerTitle: map["centerTitle"],
        titleSpacing: map["titleSpacing"],
        primary: map["primary"],
        elevation: map["elevation"],
    );
  }

  @override
  String get name => "AppBar";

}


 class AppBarElementWidget extends StatefulWidget with ElementWidgetMixin {
  AppBarElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _AppBarElementWidgetState createState() => _AppBarElementWidgetState();
}

class _AppBarElementWidgetState extends State<AppBarElementWidget> with ElementWidgetStateMixin<AppBarElement, AppBarElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: AppBar(
          title: getChildOrDragTarget(
               childId: element.findIdForSlot(AppBarElement.TITLE),
               data: SlotData(slotName: AppBarElement.TITLE), 
             ),          leading: getChildOrDragTarget(
               childId: element.findIdForSlot(AppBarElement.LEADING),
               data: SlotData(slotName: AppBarElement.LEADING), 
             ),        
         automaticallyImplyLeading: element.automaticallyImplyLeading.value,
         backgroundColor: element.backgroundColor.value,
         brightness: element.brightness.value,
         bottomOpacity: element.bottomOpacity.value,
         toolbarOpacity: element.toolbarOpacity.value,
         centerTitle: element.centerTitle.value,
         titleSpacing: element.titleSpacing.value,
         primary: element.primary.value,
         elevation: element.elevation.value,
        )
    );
  }

} 
  