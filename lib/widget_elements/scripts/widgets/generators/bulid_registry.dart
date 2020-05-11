import 'dart:io';

import 'package:widget_maker_2_0/widget_elements/scripts/widgets/models.dart';






Future writeRegistry(List<ParsedWidget> widgets) async {

  List<String> res = widgets.map((it) {
    return convert(it);
  }).toList();
  var file = File("../generated/registry.dart");


  String code = """
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/bars/palette/palette_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/data/widget_elements/display/display.dart';
${getImports(widgets).join("\n")}

class R2D2 {

${res.join("\n")}


  List<PaletteItem> get allItems => [
${widgets.map((it) => "    " + makeFirstSmall(it.name)).join(",\n")}
  ];
  
  
  Map<String, List<PaletteItem>> get categories => {
${mapToCategoriesToCode(mapToCategories(widgets))}
  };
  
}
  """;
  await file.writeAsString(code);
}

String mapToCategoriesToCode(Map<String, List<ParsedWidget>> it) {

  String res = "";
  for(String key in it.keys) {
    String map = """
    \"$key\": [
${it[key].map((it) => "       ${makeFirstSmall(it.name)}").join(",\n")}
    ],
    """;
    res += map;
  }

  return res;

}

Map<String, List<ParsedWidget>> mapToCategories(List<ParsedWidget> parsedWidget) {
  Map<String, List<ParsedWidget>> res = {};

  for(ParsedWidget it in parsedWidget) {
    for(String category in it.meta.categories) {
      if(!res.containsKey(category)) {
        res[category] = [];
      }
      res[category].add(it);
    }
  }

  return res;
}



Iterable<String> getImports(List<ParsedWidget> widgets) {
  return widgets.map((it) => "import 'package:widget_maker_2_0/data/widget_elements/generated/widgets/${it.name}.dart';").toList();
}

String convert(ParsedWidget it) {
  String name = it.name;
  WidgetMeta meta = it.meta;

  String category = "categories: [\n"
      "${it.meta.categories.map((it) => "     \"$it\"").join(",\n")}"
      "\n    ],";

  return """
  PaletteItem ${makeFirstSmall(name)} = PaletteItem(
    name: "${it.actualName}",
    icon: ${meta.icon == null? "Icons.add": "Icons.${meta.icon}"},${meta.widget == null? "": "\n    widget: ${meta.widget}(),"}
    $category
    generator: (id) => ${name}Element(id: id),
  );
  """;
}

String makeFirstSmall(String it) {
  String starting = it.substring(0,1);
  return it.replaceRange(0, 1, starting.toLowerCase());
}