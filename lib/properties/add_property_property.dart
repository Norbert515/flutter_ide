import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/properties/basic_properties.dart';
import 'package:widget_maker_2_0/properties/value_changers/widgets/changers.dart';
import 'package:widget_maker_2_0/widget_elements/base/literal_widget.dart';


class AddPropertyProperty extends MProperty with SingleChangerMixin {

  AddPropertyProperty({String name}): super(name: name);


  @override
  AddPropertyProperty copy() {
    return AddPropertyProperty(
      name: name,
    );
  }
  @override
  Widget buildChanger(BuildContext context, String id) {
    return Material(
      child: RoundContainer(
        child: InkWell(
          onTap: () async {
            PropertyType type = await showDialogAtContext(
                context: context,
                size: Size(240, 400),
                top: false,
                builder: (context) {
                  return Material(
                    child: Container(
                      child: ListView(
                        children: PropertyType.values.map((it) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(it);
                          },
                          child: Text(it.toString().split(".")[1]),
                        )).toList()
                      ),
                    ),
                  );
                }
            );
            LiteralWidgetElement it = AppScope.of(context).widgetBoard.getWidgetElementFromAnySource(id);
            it.addProperty(type, "test");
            updateValue(null, context, id);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  Expression toCode() {
    return CodeExpression(Code(""));
  }

}