import 'dart:math';
import 'package:code_builder/code_builder.dart' as a;
import 'package:code_builder/code_builder.dart' show Expression;
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:meta/meta.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/constraints_changer.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/instanced_widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/literal_widget.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:widget_maker_2_0/ui/board_widget.dart';
import 'package:widget_maker_2_0/ui/theme.dart';
import 'package:widget_maker_2_0/ui/widgets/dialogs/select_variable_dialog.dart';

import 'value_changers/alignment_changer.dart';
import 'value_changers/bool_changer.dart';
import 'value_changers/color_changer.dart';
import 'value_changers/edge_insets_changer.dart';
import 'value_changers/string_changer.dart';
import 'value_changers/widgets/changers.dart';
import 'value_changers/widgets/multi_changer.dart';
import 'value_changers/widgets/number_changer.dart';
import 'value_changers/widgets/value_row.dart';

class NamedWidget {
  final Widget widget;
  final String name;

  NamedWidget({this.widget, this.name});
}

class PropertyReference {

  PropertyReference({this.propertyName, this.elementId});

  final String propertyName;
  final String elementId;


}

typedef ValueGetter<T> = T Function();

/// All classes prefixed with "M" to avoid collision with Flutters diagnostics library
///
/// A property represents a runtime version of all available property, it includes
/// all sorts of meta information to the runtime.
///
/// [MProperty] is mutable, it contains the value of its represented type, only that
/// is mutable.
///
/// For the sake of convenience, properties build their own changers. And manage
/// their own updates.
///
/// Changers are giving full control about the space they occupy, their only
/// goal is to provide a way to change that value.
///
/// There is no need to listen to properties as it interfaces with the widget board
/// and updates the according value. This might be subject to changes later.
///
/// Equality is defined over the name as property can never have the same name and be different
///
abstract class MProperty<T> {
  MProperty({
    this.name = "No Name",
    T value,
    String displayName,
    this.isNamed = true,
    this.isRequired = false,
    this.nullable = true,
    @required this.defaultValue,
  }) : this.displayName = displayName ?? capitalize(name), _value = value;

  /// The name to be displayed in the changer widget
  final String displayName;

  /// The actual property name as it is in the source code
  final String name;

  /// The value of this property
  ///
  /// Is mutable
  T _value;
  T get value {
    if(isReference) {
      var element = AppScope.debugProject.widgetBoard.getWidgetElementFromAnySource(propertyReference.elementId);
      var property = element.attributes.where((it) => it.name == propertyReference.propertyName).first;
      return property.value;
    }
    return _value;
  }
  set value(T it) {
    _value = it;
  }

  /// Whether this is a positioned property
  bool isNamed;

  /// Whether it is required to specify this property in source code
  final bool isRequired;

  /// Whether this property is allowed to be expicitly null
  final bool nullable;

  /// The value to compare to when doing code gen and deciding whether to omit it or not
  final T defaultValue;

  /// Indicated whether this property is a reference and therefore does not
  /// contain a literate value
  bool get isReference => propertyReference != null;


  /// A reference to another property.
  ///
  /// If this is not null then this property doesn't hold a value on its own but
  /// instead references to another reference
  PropertyReference propertyReference;


  /// Indicates whether this property was updated at least once
  ///
  /// This is used for the code generation part, if the variable was never mutated
  /// and it is a default property, then it can be omitted
  bool wasMutated = false;

  //bool get shouldBeOmitted => !wasMutated && !isRequired;
  bool get shouldBeOmitted => defaultValue == value;

  void updateValue(T newValue, BuildContext context, String id) {
    wasMutated = true;
    value = newValue;
    AppScope.of(context).widgetBoard.notifyUpdate(id, affectsLayout: false);
  }

  Widget getChanger(BuildContext context, String id) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: buildFinalChanger(context, id),
    );
  }

  Widget buildFinalChanger(BuildContext context, String id);

  Expression toCode();

  static String capitalize(String it) {
    if (it == null) return null;
    if (it.isEmpty) return it;
    var first = it.substring(0, 1).toUpperCase();
    return first + it.substring(1);
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MProperty &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  /// Copies this propert and returns a new property containing state etc.
  ///
  /// This is useful when wanting the have another property which contains a different state
  MProperty<T> copy();
}

/// A property which is the composition of other properties.
///
///
abstract class MObjectProperty<T> extends MProperty<T> with SingleChangerMixin{

  MObjectProperty({
    String name = "No Name",
    T value,
    @required T defaultValue,
  }) : internalValue = value, super(name: name, value: value, defaultValue: defaultValue);

  List<MProperty> getProperties();
  T constructEmpty();

  T internalValue;




  @override
  set value(it) {
    internalValue = it;
  }
  @override
  T get value => internalValue;

  @override
  Widget buildChanger(BuildContext context, String id) {
    return GestureDetector(
      onTap: () {
        if(internalValue == null) {
          value = constructEmpty();
          updateValue(constructEmpty(), context, id);
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => buildPage(context, id)
        ));
      },
      child: RoundContainer(
        child: value == null? buildAddButton(context, id): buildTappableButton(context, id),
      ),
    );
  }

  Widget buildAddButton(BuildContext context, String id) {
    return Icon(Icons.add);
  }

  Widget buildTappableButton(BuildContext context, String id) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name),
    ));
  }

  Widget buildPage(BuildContext context, String id) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(name),
      ),
      backgroundColor: MyTheme.of(context).background4dp,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: getProperties().map((it) => it.getChanger(context, id)).toList(),
          ),
        ),
      ),
    );
  }

}

mixin SingleChangerMixin<T> on MProperty<T> {

  @override
  Widget buildFinalChanger(BuildContext context, String id) {
    return ValueRow(
      text: name,
      child: buildChanger(context, id),
      onVariableTap: () async {
        var widgetBoard = AppScope.of(context).widgetBoard;
        LiteralWidgetElement element = widgetBoard.getFirstLiteralWidgetElementAncestor(id);
        MProperty property = await showDialogAtContext(context: context, builder: (context) {
          return SelectVariableDialog(
            properties: element.addedProperties,
          );
        }, size: Size(100, 100));

        propertyReference = PropertyReference(
          elementId: element.id,
          propertyName: property.name,
        );
      },
    );
  }

  Widget buildChanger(BuildContext context, String id);
}
/*
mixin DifferentConstructorChangerMixin<T, R> on MProperty<T> {
  R get selectedOption;
  set selectedOption(R it);

  @override
  Widget buildFinalChanger(BuildContext context, String id) =>
      StatefulBuilder(builder: (context, stateSetter) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                PropertyText(text: name),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: OutlineDropDownButton<R>(
                    value: selectedOption,
                    items: options.map((it) {
                      return DropdownMenuItem<R>(
                        value: it,
                        child: Text(names[options.indexOf(it)]),
                      );
                    }).toList(),
                    onChanged: (it) {
                      selectedOption = it;
                      onChange();
                      stateSetter(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            buildChangerForOption(context, id, selectedOption),
          ],
        );
      });

  VoidCallback get onChange => () {};

  Widget buildChangerForOption(BuildContext context, String id, R option);

  List<R> get options;
  List<String> get names;
}*/

class MWIPProperty<T> extends MProperty<T> with SingleChangerMixin {
  MWIPProperty({
      T value,
      String name,
      bool isNamed = true,
      bool isRequired = false,
      @required T defaultValue,
      })
      : super(
            name: name,
            value: value,
            isNamed: isNamed,
            isRequired: isRequired,
            defaultValue: defaultValue,
  );

  @override
  Widget buildChanger(BuildContext context, String id) {
    return Text("This attribute is WIP");
  }

  @override
  Expression toCode() {
    return a.literal("WIP");
  }

  @override
  MWIPProperty<T> copy() {
    return MWIPProperty(
      value: value,
      name: name,
      isNamed: isNamed,
      isRequired: isRequired,
      defaultValue: defaultValue
    );
  }
}

class MDoubleProperty extends MProperty<double> with SingleChangerMixin {
  MDoubleProperty({
    @required double value,
    @required String name,
    this.showDescription = false,
    this.allowNegative = false,
    bool isNamed = true,
    bool isRequired = false,
    @required double defaultValue,
  }) : super(value: value, name: name, isNamed: isNamed, isRequired: isRequired, defaultValue: defaultValue);

  final bool showDescription;
  final bool allowNegative;

  @override
  MDoubleProperty copy() {
    return MDoubleProperty(
      value: value,
      name: name,
      showDescription: showDescription,
      allowNegative: allowNegative,
      isNamed: isNamed,
      isRequired: isRequired,
      defaultValue: defaultValue,
    );
  }

  @override
  Widget buildChanger(BuildContext context, String id) {
    return NumberChanger(
      showDescription: showDescription,
      allowNegative: allowNegative,
      name: name,
      value: value,
      onUpdate: (update) {
        updateValue(update, context, id);
      },
    );
  }

  static Expression convertToCode(double value) => a.literal(value);

  @override
  Expression toCode() => convertToCode(value);

}

class MIntProperty extends MProperty<int> with SingleChangerMixin {
  MIntProperty({
    @required int value,
    @required String name,
    isNamed = true,
    isRequired = false,
    this.allowNegative = true,
    @required int defaultValue,
  })
      : super(value: value, name: name, isNamed: isNamed, isRequired: isRequired, defaultValue: defaultValue);


  final bool allowNegative;
  @override
  MIntProperty copy() {
    return MIntProperty(
      value: value,
      name: name,
      isNamed: isNamed,
      isRequired: isRequired,
      defaultValue: defaultValue,
    );
  }
  @override
  Widget buildChanger(BuildContext context, String id) {
    return NumberChanger(
      name: name,
      value: value.toDouble(),
      allowNegative: allowNegative,
      onUpdate: (update) {
        updateValue(update.round(), context, id);
      },
    );
  }

  static Expression convertToCode(int value) => a.literal(value);

  @override
  Expression toCode() => convertToCode(value);
}

class MAlignmentProperty extends MProperty<Alignment> with SingleChangerMixin {
  MAlignmentProperty({
       @required Alignment value,
       @required String name,
        bool isNamed = true,
        bool isRequired = false,
        @required Alignment defaultValue,
      })
      : super(value: value, name: name, isNamed: isNamed, isRequired: isRequired, defaultValue: defaultValue);


  @override
  MAlignmentProperty copy() {
    return MAlignmentProperty(
      value: value,
      name: name,
      isNamed: isNamed,
      isRequired: isRequired,
      defaultValue: defaultValue,
    );
  }

  @override
  Widget buildChanger(BuildContext context, String id) {
    return AlignmentChanger(
      value: value,
      size: Size(50, 50),
      onUpdate: (it) {
        updateValue(it, context, id);
      },
    );
  }

  static Expression convertToCode(Alignment value) {
    if(value == null) return null;
    if (value == Alignment.centerRight) {
      return a.refer("Alignment").property("centerRight");
    } else if (value == Alignment.centerRight) {
      return a.refer("Alignment").property("centerRight");
    } else if (value == Alignment.centerLeft) {
      return a.refer("Alignment").property("centerLeft");
    } else if (value == Alignment.center) {
      return a.refer("Alignment").property("center");
    } else if (value == Alignment.topLeft) {
      return a.refer("Alignment").property("topLeft");
    } else if (value == Alignment.topCenter) {
      return a.refer("Alignment").property("topCenter");
    } else if (value == Alignment.topRight) {
      return a.refer("Alignment").property("topRight");
    } else if (value == Alignment.bottomLeft) {
      return a.refer("Alignment").property("bottomLeft");
    } else if (value == Alignment.bottomRight) {
      return a.refer("Alignment").property("bottomRight");
    } else if (value == Alignment.bottomCenter) {
      return a.refer("Alignment").property("bottomCenter");
    }
    return a.refer("Alignment").newInstance([
      a.literalNum(value.x),
      a.literalNum(value.y),
    ]);
  }

  @override
  Expression toCode() => convertToCode(value);

}

class MStringProperty extends MProperty<String> with SingleChangerMixin {
  MStringProperty({
    @required String value,
    @required String name,
    bool isNamed = true,
    bool isRequired = false,
    @required String defaultValue,
  }) : super(
            value: value,
            name: name,
            isNamed: isNamed,
            isRequired: isRequired,
    defaultValue: defaultValue,
  );


  @override
  MStringProperty copy() {
    return MStringProperty(
      value: value,
      name: name,
      isNamed: isNamed,
      isRequired: isRequired,
      defaultValue: defaultValue,
    );
  }
  @override
  Widget buildChanger(BuildContext context, String id) {
    return StringChanger(
      value: value,
      onUpdate: (it) {
        updateValue(it, context, id);
      },
    );
  }

  static Expression convertToCode(String value) => a.literal(value);

  @override
  Expression toCode() => convertToCode(value);
}

class MBoolProperty extends MProperty<bool> with SingleChangerMixin {
  MBoolProperty({
    @required bool value,
    @required String name,
    bool isRequired = false,
    bool isNamed = true,
    @required bool defaultValue,
  }) : super(
          value: value,
          name: name,
          isRequired: isRequired,
          isNamed: isNamed,
          defaultValue: defaultValue,
        );


  @override
  MBoolProperty copy() {
    return MBoolProperty(
      value: value,
      name: name,
      isRequired: isRequired,
      isNamed: isNamed,
      defaultValue: defaultValue,
    );
  }

  @override
  Widget buildChanger(BuildContext context, String id) {
    return BoolChanger(
      value: value,
      nullable: !isRequired,
      onUpdate: (it) {
        updateValue(it, context, id);
      },
    );
  }

  static Expression convertToCode(bool value) => a.literal(value);

  @override
  Expression toCode() => convertToCode(value);
}

class MBoxConstraintsProperty extends MProperty<BoxConstraints>
    with SingleChangerMixin {
  MBoxConstraintsProperty({
    @required BoxConstraints value,
    @required String name,
    bool isRequired = false,
    bool isNamed = true,
    @required BoxConstraints defaultValue,
  }) : super(value: value, name: name, isNamed: isNamed, isRequired: isRequired, defaultValue: defaultValue);


  @override
  MBoxConstraintsProperty copy() {
    return MBoxConstraintsProperty(
      value: value,
      name: name,
      isRequired: isRequired,
      isNamed: isNamed,
      defaultValue: defaultValue,
    );
  }
  @override
  Widget buildChanger(BuildContext context, String id) {
    return SizedBox();
    return ConstraintsChanger(
      constraints: value,
      onUpdate: (it) {
        updateValue(it, context, id);
      },
    );
  }

  @override
  Expression toCode() {
  }
}
/*
class MEdgeInsetsProperty extends MProperty<EdgeInsets>
    with DifferentConstructorChangerMixin<EdgeInsets, EdgeInsetsMode> {
  MEdgeInsetsProperty({
    @required EdgeInsets value,
    @required String name,
    bool isRequired = false,
    bool isNamed = true,
  }) : super(value: value, name: name, isRequired : isRequired, isNamed: isNamed);

  @override
  EdgeInsetsMode selectedOption = EdgeInsetsMode.none;

  @override
  Expression toCode() {
  }

  @override
  Widget buildChangerForOption(
      BuildContext context, String id, EdgeInsetsMode option) {
    return EdgeInsetsChanger(
      mode: option,
      edgeInsets: value,
      onUpdate: (it) {
        updateValue(it, context, id);
      },
    );
  }

  @override
  VoidCallback get onChange => () {
        var minimum = min<double>(
            min<double>(min<double>(value.left, value.right), value.top),
            value.bottom);
        value = EdgeInsets.all(minimum);
      };

  @override
  List<EdgeInsetsMode> get options => EdgeInsetsMode.values;

  @override
  List<String> get names => ["all", "only", "symmetrical", "none"];
}
*/
class MColorProperty extends MProperty<Color> with SingleChangerMixin {
  MColorProperty(
      {@required Color value, @required String name, bool isNamed = true, bool isRequired = false, @required Color defaultValue})
      : super(value: value, name: name, isNamed: isNamed, isRequired: isRequired, defaultValue: defaultValue);


  @override
  MColorProperty copy() {

  }

  @override
  Widget buildChanger(BuildContext context, String id) {
    return ColorChanger(
      onUpdate: (it) {
        updateValue(it, context, id);
      },
      value: value,
    );
  }

  static Expression convertToCode(Color value) {
    if(value == null) return a.literalNull;
    return a.refer("Color").newInstance([a.CodeExpression(a.Code("0x${value.value.toRadixString(16)}"))]);
  }

  @override
  Expression toCode() => convertToCode(value);

}



class MEdgeInsetsProperty extends MProperty<EdgeInsets> {
  MEdgeInsetsProperty({
    @required EdgeInsets value,
    @required String name,
    bool isRequired = false,
    bool isNamed = true,
    @required EdgeInsets defaultValue,
  }) : super(value: value, name: name, isRequired : isRequired, isNamed: isNamed, defaultValue: defaultValue);

  EdgeInsetsMode selectedOption = EdgeInsetsMode.none;


  @override
  MEdgeInsetsProperty copy() {
    return MEdgeInsetsProperty(
      value: value,
      name: name,
      isRequired: isRequired,
      isNamed: isNamed,
      defaultValue: defaultValue,
    );
  }
  @override
  Expression toCode() {
    if(value.left == value.right && value.bottom == value.top && value.left == value.top) {
      return a.refer("EdgeInsets").newInstanceNamed("all", [a.literal(value.left)]);
    } else if(value.left == value.right && value.top == value.bottom) {
      return a.refer("EdgeInsets").newInstanceNamed("symmetric", [],
        {
          "horizontal": a.literal(value.left),
          "vertical": a.literal(value.top),
        }
      );
    } else {
      return a.refer("EdgeInsets").newInstanceNamed("only", [],
        {
          "left": a.literal(value.left),
          "right": a.literal(value.right),
          "bottom": a.literal(value.bottom),
          "top": a.literal(value.top),
        }
      );
    }
  }

  VoidCallback get onChange => () {
    var minimum = min<double>(
        min<double>(min<double>(value.left, value.right), value.top),
        value.bottom);
    value = EdgeInsets.all(minimum);
  };

  List<EdgeInsetsMode> get options => EdgeInsetsMode.values;
  List<String> get names => ["all", "only", "symmetrical", "none"];


  void change(EdgeInsetsMode it, StateSetter stateSetter) {
    selectedOption = it;
    if(value == null && it != EdgeInsetsMode.none) {
      value = EdgeInsets.all(0.0);
    }
    onChange();
    stateSetter(() {});
  }

  @override
  Widget buildFinalChanger(BuildContext context, String id) {
    return StatefulBuilder(
      builder: (context, stateSetter) {
        return MultiChanger<EdgeInsetsMode>(
          onChange: (dynamic it) => change(it, stateSetter),
          name: name,
          changer: EdgeInsetsChanger(
            mode: selectedOption,
            edgeInsets: value,
            onUpdate: (EdgeInsets it) {
              updateValue(it, context, id);
            },
          ),
          names: names,
          options: options,
          selectedOption: selectedOption,
        );
      }
    );
  }

}