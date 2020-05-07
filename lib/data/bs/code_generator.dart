import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/meta.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import '../widget_elements/base/literal_widget.dart';


abstract class ICodeGenerator {

  String generateCode(Map<String, CanvasElement> canvases, Map<String, WidgetElement> allElements);
}

class SingleFileCodeGenerator extends ICodeGenerator {

  @override
  String generateCode(Map<String, CanvasElement> canvases, Map<String, WidgetElement> allElements) {


    List<Class> classes = canvases.keys.map((canvasId) {
      final String classCode = canvases[canvasId].writeCode2(allElements);
      String literalWidgetElementId = allElements[canvasId].children[0].childrenIds[0];
      LiteralWidgetElement literalWidgetElement = allElements[literalWidgetElementId];
      return Class((b) =>
      b
        ..name = literalWidgetElement.widgetName.value.replaceAll(" ", "")
        ..extend = refer("StatelessWidget", "import 'package:widget_maker_2_0/material.dart'")
        ..methods.add(Method((a) =>
        a
          ..name = "build"
          ..annotations.add(refer("override"))
          ..requiredParameters.add(Parameter((it) => it..type = refer("BuildContext")..name = "context"))
          ..returns = refer("Widget")
          ..body = Code("return $classCode;")

        ))
      );
    }).toList();

    var library = Library((b) {
      b.body.addAll(classes);

      b.directives.addAll([
        Directive.import("package:flutter/material.dart")
      ]);
      return b;
    });

    final l = DartFormatter(
    ).format('${library.accept(DartEmitter())}');
    print(l);

    return l;
  }
}