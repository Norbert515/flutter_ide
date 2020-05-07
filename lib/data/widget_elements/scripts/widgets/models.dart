
import 'package:widget_maker_2_0/data/widget_elements/scripts/widgets/generators/build_widget.dart';

import '../build.dart';

class Size {
  final double width;
  final double height;

  Size(this.width, this.height);

  Map<String, dynamic> toMap() {
    return {
      'width': this.width,
      'height': this.height,
    };
  }

}

class IdAndData {
  final String id;
  final Object data;
  final Size maxEmptySize;

  IdAndData({this.id, this.data, this.maxEmptySize});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'data': this.data,
      'maxEmptySize': this.maxEmptySize,
    };
  }
}

enum SlotType {
  list, widget,
}

class Slot {

  Slot({this.name, this.type, this.maxEmptySize});

  final String name;
  final SlotType type;
  final Size maxEmptySize;

  String toCode() {
    switch(type) {
      case SlotType.list:
        return "ListChildSlot";
      case SlotType.widget:
        return "SingleChildSlot";
    }
  }

  String toSerializationType() {
    switch(type) {
      case SlotType.list:
        return "List<Widget>";
      case SlotType.widget:
        return "Widget2";
    }
  }

  String finalSerializeCode() {
    switch(type) {
      case SlotType.list:
        return """
        int i = 0;
        for(Widget widget in widget.$name) {
          _deserializeWidgetElement(widget, widgetBoard, element.id, SlotData(slotName: \'$name\', data: i));
          i++;
        }
        """;
      case SlotType.widget:
        return '_deserializeWidgetElement(widget.$name, widgetBoard, element.id, SlotData(slotName: \'$name\', data: null));';
        return "this.$name.toMap()";
    }
  }
  String serialize() {
    switch(type) {
      case SlotType.list:
        return "this.$name.map((it) => it.toMap()).toList()";
      case SlotType.widget:
        return "this.$name.toMap()";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'type': this.type,
    };
  }

}

abstract class LayoutModel {

  const LayoutModel();

  String get getMixin;

  Map<Slot, IdAndData> getPropertyAccess();

  List<Map<String, String>> get properties;
}

class NoChildLayoutModel extends LayoutModel{

  const NoChildLayoutModel();

  @override
  String get getMixin => "NoChildElementMixin";

  @override
  Map<Slot, IdAndData> getPropertyAccess() {
    return {};
  }

  @override
  List<Map<String, String>> get properties => [];


}

class SlotChildLayoutModel extends LayoutModel{

  final List<Slot> slotNames;
  final String widgetName;

  SlotChildLayoutModel({this.widgetName, this.slotNames});

  @override
  String get getMixin => "SlotChildElementMixin";

  @override
  Map<Slot, IdAndData> getPropertyAccess() {
    return slotNames.asMap().map<Slot, IdAndData>((int key, Slot value) {
      return MapEntry<Slot, IdAndData>(value, IdAndData(
        id: getAccessor(value.name),
        data: "SlotData(slotName: ${widgetName}Element.${value.name.toUpperCase()})",
        maxEmptySize: value.maxEmptySize,
      ));
    });
  }

  //String getAccessor(String value) => "${widgetName}Element.${value.toUpperCase()}";
  String getAccessor(String value) => "findIdForSlot(${widgetName}Element.${value.toUpperCase()})";

  @override
  List<Map<String, String>> get properties => slotNames.map((it) {
    return {
      'name': it.name,
      'type': it.toSerializationType(),
      'serializer': it.serialize(),
      'fCode': it.finalSerializeCode(),

    };
  }).toList();
}


class ParsedWidget {

  final List<ParsedProperty> properties;
  final WidgetMeta meta;
  final String name;
  final String actualName;
  final GeneralInfo generalInfo;


  String get elementName => "${name}Element";

  ParsedWidget({this.generalInfo, this.name, this.properties, this.meta, String actualName}): this.actualName = actualName?? name;

  Map<String, dynamic> toMap() {
    return {
      'positionalProperties': this.properties.where((it) => it.positional).map((it) => it.toMap()).toList(),
      'namedProperties': this.properties.where((it) => !it.positional).map((it) => it.toMap()).toList(),
      // All properties
      'properties': this.properties.map((it) => it.toMap()).toList(),
      'meta': this.meta.toMap(),
      'name': this.name,
      'refName': generalInfo?.useWidget?? "${elementName}Widget",
      'elementName': this.elementName,
      'generalInfo': this.generalInfo.toMap(),
      'mixin': generalInfo.layoutModel.getMixin,
      'import': generalInfo?.useWidget == null? "": "import 'package:widget_maker_2_0/data/widget_elements/widgets/${name.toLowerCase()}.dart';" ,
      'generatedWidget': generateWidget(this),
      'slots': getMaybeSlots(this),
      'actualName': actualName,

    };
  }

}


class GeneralInfo {

  final String useWidget;
  final LayoutModel layoutModel;

  GeneralInfo({this.useWidget, this.layoutModel = const NoChildLayoutModel()});

  Map<String, dynamic> toMap() {
    return {
      'useWidget': this.useWidget,
      'layoutModel': this.layoutModel.properties,
    };
  }
}

class ParsedProperty {
  final String name;
  final String type;
  final bool positional;
  final Map<String, String> customAttributes;
  final dynamic defaultValue;
  final bool wip;

  ParsedProperty({this.wip = false, this.type, this.name, this.positional = false, this.customAttributes = const {}, this.defaultValue});


  String get propertyConstructorName {
    return wip? "MWIPProperty<$type>"
        : "M${makeFirstBig(type)}Property";
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'type': this.type,
      'positional': this.positional,
      'customAttributes': this.customAttributes.keys.map((key) => {'key': key, 'value': customAttributes[key]}).toList(),
      'defaultValue': _escapeDefaultValue(this.defaultValue)?? "null",
      'wip': wip,
      'propertyConstructorName': propertyConstructorName,
    };
  }

  dynamic _escapeDefaultValue(dynamic it) {
    if(it != null && it is String && it.startsWith("\\")) {
      return "\"${it.substring(1)}\"";
    }
    return it;
  }
}

class WidgetMeta {

  final String icon;
  final String widget;
  final List<String> categories;

  WidgetMeta({this.categories, this.icon, this.widget});

  Map<String, dynamic> toMap() {
    return {
      'icon': this.icon,
      'widget': this.widget,
      'categories': this.categories,
    };
  }

}