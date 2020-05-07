import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/icon_data_changer.dart';
import 'package:widget_maker_2_0/data/string_builder.dart';
import 'basic_properties.dart';
import 'icon_property/m_icons.dart';

class MIconDataProperty extends MProperty<IconData> with SingleChangerMixin {
  MIconDataProperty(
      {@required IconData value, @required String name, bool isNamed = true, bool isRequired = false, @required IconData defaultValue})
      : super(value: value, name: name, isNamed: isNamed, isRequired: isRequired, defaultValue: defaultValue);

  @override
  MIconDataProperty copy() {
    return MIconDataProperty(
      value: value,
      name: name,
      isNamed: isNamed,
      isRequired: isRequired,
    );
  }

  @override
  Widget buildChanger(BuildContext context, String id) {
    return IconDataChanger(
      value: value,
      onUpdate: (it) {
        updateValue(it, context, id);
      },
    );
  }

  @override
  Expression toCode() {
    if(value == null) return literalNull;
    return refer("Icons").property(MIconContainer.iconDataToName[value]);
  }
}


class MIconData {

  final IconData icon;
  final String name;

  const MIconData({this.icon, this.name});
}
