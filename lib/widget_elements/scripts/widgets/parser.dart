import 'package:yaml/yaml.dart';
import 'models.dart';

ParsedWidget parseWidget(String name, YamlMap map) {

  List<ParsedProperty> properties = [];
  WidgetMeta meta = WidgetMeta();
  GeneralInfo generalInfo = GeneralInfo();

  if(map != null) {
    if (map.containsKey("prop")) {
      properties = parseProperties(map["prop"]);
    }
    meta = parseWidgetMeta(map["meta"]);
    generalInfo = parseGenerationInfo(name, map["general"]);
  }

  return ParsedWidget(
    name: name,
    properties: properties,
    meta: meta,
    generalInfo: generalInfo,
    actualName: map["actualName"],
  );
}


GeneralInfo parseGenerationInfo(String name, YamlMap info) {
  if(info == null)
    return GeneralInfo(
      layoutModel: NoChildLayoutModel()
    );

  LayoutModel layoutModel;

  if(info["layout"] == "single") {
    layoutModel = SlotChildLayoutModel(
      widgetName: name,
      slotNames: [Slot(
        name: "child",
        type: SlotType.widget,
      )]
    );
  } else if(info["layout"] == "none" || info["layout"] == null) {
    layoutModel = NoChildLayoutModel();
  } else if(info["layout"] is YamlMap) {
    YamlList slots = info["layout"]["slots"];
    if(slots != null) {
      List<Slot> pSlots = [];
      for (var it in slots) {
        if (it is String) {
          pSlots.add(Slot(
              name: it,
              type: SlotType.widget
          ));
        } else if (it is YamlMap) {
          pSlots.add(Slot(
              name: it["slot"]["name"],
              type: SlotType.values.where((t) =>
              t.toString().split(".")[1] == it["slot"]["type"]
              ).first
          ));
        }
      }
      layoutModel = SlotChildLayoutModel(
        widgetName: name,
        slotNames: pSlots,
      );
    } else if(info["layout"]["single"]["maxWidth"] != null) {
      // Is a single child layout with max empty size
      assert(info["layout"]["single"]["maxHeight"] != null);
      layoutModel = SlotChildLayoutModel(
          widgetName: name,
          slotNames: [Slot(
            name: "child",
            type: SlotType.widget,
            maxEmptySize: Size(info["layout"]["single"]["maxWidth"], info["layout"]["single"]["maxHeight"]),
          )]
      );
    }
  }
  return GeneralInfo(
    useWidget: info["widget"],
    layoutModel: layoutModel
  );
}

List<ParsedProperty> parseProperties(YamlMap properties) {

  List<ParsedProperty> parsedProperties = [];

  for(String property in properties.keys) {

    if(property == "meta" || property == "widget")
      continue;

    if(properties[property] is String) {

      parsedProperties.add(ParsedProperty(
        name: property,
        type: properties[property],
      ));

    } else if(properties[property] is YamlMap) {

      YamlMap map = properties[property];

      Map<String, String> other = {};

      for(String key in map.keys) {
        if(key != "type" && key != "positional" && key != "default" && key != "wip") {
          other[key] = map[key].toString();
        }
      }
      parsedProperties.add(ParsedProperty(
          type: map["type"],
          name: property,
          positional: map["positional"]?? false,
          customAttributes: other,
          defaultValue: map["default"],
          wip: map["wip"]?? false

      ));
    }
  }
  return parsedProperties;
}

WidgetMeta parseWidgetMeta(YamlMap meta) {
  if(meta == null)
    return WidgetMeta(
      categories: ["None"]
    );

  List<String> categories;
  if(meta["categories"] != null && meta["categories"] is YamlList) {
    categories = [];
    for(String it in meta["categories"]) {
      categories.add(it);
    }
  } else {
    categories = ["None"];
  }

  return WidgetMeta(
    widget: meta["display"],
    icon: meta["icon"],
    categories: categories,
  );
}