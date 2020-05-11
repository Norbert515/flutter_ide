import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/modules/code_generation/code_builder.dart';
import 'package:widget_maker_2_0/properties/enum_properties.dart';
import 'package:widget_maker_2_0/properties/basic_properties.dart';
import 'package:code_builder/code_builder.dart';
import 'enums.dart';
import 'package:widget_maker_2_0/properties/wrappers/wrappers.dart';

/// All the enum properties
/// GENERATED DO NOT TOUCH

class MWDurationProperty extends MObjectProperty<WDuration> {

  MWDurationProperty({ WDuration value, String name, WDuration defaultValue}):
      props = {
        "days": MIntProperty(
            name: "days",
            value: value?.days,
            allowNegative: false,
            defaultValue: const WDuration().days,
          ),
        "hours": MIntProperty(
            name: "hours",
            value: value?.hours,
            allowNegative: false,
            defaultValue: const WDuration().hours,
          ),
        "minutes": MIntProperty(
            name: "minutes",
            value: value?.minutes,
            allowNegative: false,
            defaultValue: const WDuration().minutes,
          ),
        "seconds": MIntProperty(
            name: "seconds",
            value: value?.seconds,
            allowNegative: false,
            defaultValue: const WDuration().seconds,
          ),
        "milliseconds": MIntProperty(
            name: "milliseconds",
            value: value?.milliseconds,
            allowNegative: false,
            defaultValue: const WDuration().milliseconds,
          ),
        "microseconds": MIntProperty(
            name: "microseconds",
            value: value?.microseconds,
            allowNegative: false,
            defaultValue: const WDuration().microseconds,
          ),
      }, super(name: "WDuration", value: value, defaultValue: defaultValue);

  final Map<String, MProperty> props;

  @override
  MWDurationProperty copy() {
    return MWDurationProperty(
      value: value,
      name: name,
    );
  }

  @override
  List<MProperty> getProperties() {
    return props.values.toList();
  }
  @override
  WDuration get value => internalValue == null? null: WDuration(
    days: props["days"].value,
    hours: props["hours"].value,
    minutes: props["minutes"].value,
    seconds: props["seconds"].value,
    milliseconds: props["milliseconds"].value,
    microseconds: props["microseconds"].value,
  );

  Map<String, dynamic> toMap() {
    return {
       "days": props["days"].value.serialize(),
       "hours": props["hours"].value.serialize(),
       "minutes": props["minutes"].value.serialize(),
       "seconds": props["seconds"].value.serialize(),
       "milliseconds": props["milliseconds"].value.serialize(),
       "microseconds": props["microseconds"].value.serialize(),
    };
  }

  @override
  Expression toCode() {
    return propertyConstructor("WDuration", props.values);
  }
  @override
  WDuration constructEmpty() => WDuration();

}
class MTextStyleProperty extends MObjectProperty<TextStyle> {

  MTextStyleProperty({ TextStyle value, String name, TextStyle defaultValue}):
      props = {
        "fontSize": MDoubleProperty(
            name: "fontSize",
            value: value?.fontSize,
            allowNegative: false,
            showDescription: false,
            defaultValue: const TextStyle().fontSize,
          ),
        "inherit": MBoolProperty(
            name: "inherit",
            value: value?.inherit,
            defaultValue: const TextStyle().inherit,
          ),
        "color": MColorProperty(
            name: "color",
            value: value?.color,
            defaultValue: const TextStyle().color,
          ),
        "backgroundColor": MColorProperty(
            name: "backgroundColor",
            value: value?.backgroundColor,
            defaultValue: const TextStyle().backgroundColor,
          ),
        "fontWeight": MFontWeightProperty(
            name: "fontWeight",
            value: value?.fontWeight,
            defaultValue: const TextStyle().fontWeight,
          ),
        "fontStyle": MFontStyleProperty(
            name: "fontStyle",
            value: value?.fontStyle,
            defaultValue: const TextStyle().fontStyle,
          ),
        "letterSpacing": MDoubleProperty(
            name: "letterSpacing",
            value: value?.letterSpacing,
            showDescription: false,
            allowNegative: false,
            defaultValue: const TextStyle().letterSpacing,
          ),
        "wordSpacing": MDoubleProperty(
            name: "wordSpacing",
            value: value?.wordSpacing,
            allowNegative: false,
            showDescription: false,
            defaultValue: const TextStyle().wordSpacing,
          ),
        "textBaseline": MTextBaselineProperty(
            name: "textBaseline",
            value: value?.textBaseline,
            defaultValue: const TextStyle().textBaseline,
          ),
        "height": MDoubleProperty(
            name: "height",
            value: value?.height,
            allowNegative: false,
            defaultValue: const TextStyle().height,
          ),
      }, super(name: "TextStyle", value: value, defaultValue: defaultValue);

  final Map<String, MProperty> props;

  @override
  MTextStyleProperty copy() {
    return MTextStyleProperty(
      value: value,
      name: name,
    );
  }

  @override
  List<MProperty> getProperties() {
    return props.values.toList();
  }
  @override
  TextStyle get value => internalValue == null? null: TextStyle(
    fontSize: props["fontSize"].value,
    inherit: props["inherit"].value,
    color: props["color"].value,
    backgroundColor: props["backgroundColor"].value,
    fontWeight: props["fontWeight"].value,
    fontStyle: props["fontStyle"].value,
    letterSpacing: props["letterSpacing"].value,
    wordSpacing: props["wordSpacing"].value,
    textBaseline: props["textBaseline"].value,
    height: props["height"].value,
  );

  Map<String, dynamic> toMap() {
    return {
       "fontSize": props["fontSize"].value.serialize(),
       "inherit": props["inherit"].value.serialize(),
       "color": props["color"].value.serialize(),
       "backgroundColor": props["backgroundColor"].value.serialize(),
       "fontWeight": props["fontWeight"].value.serialize(),
       "fontStyle": props["fontStyle"].value.serialize(),
       "letterSpacing": props["letterSpacing"].value.serialize(),
       "wordSpacing": props["wordSpacing"].value.serialize(),
       "textBaseline": props["textBaseline"].value.serialize(),
       "height": props["height"].value.serialize(),
    };
  }

  @override
  Expression toCode() {
    return propertyConstructor("TextStyle", props.values);
  }
  @override
  TextStyle constructEmpty() => TextStyle();

}
