import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/modules/code_generation/code_builder.dart';
import 'package:widget_maker_2_0/modules/workspace/widget_board.dart';
import 'package:widget_maker_2_0/properties/basic_properties.dart';


class SlotData {
  final String slotName;
  final data;

  SlotData({this.slotName, this.data});
}

/// A slot of a child where a widget can be inserted
///
/// A child slot is only a property which happens to be a widget.
/// TODO make abstract
abstract class ChildSlot {

  ChildSlot({@required this.slotName, this.childrenIds});

  /// This is the name of the property.
  ///
  /// Common examples: child, children, body, title
  final String slotName;
  final List<String> childrenIds;

  bool get isSingleChild => childrenIds.length <= 1;

  bool get hasChild => childrenIds != null && childrenIds.length > 0;

  void insert(String id, [SlotData data]);
  void remove(String id, [SlotData data]);

  dynamic getDataForChild(String id);

  Expression generateCode(Map<String, WidgetElement> allElements);
}


class SingleChildSlot extends ChildSlot {


  SingleChildSlot({@required String slotName, String childId})
    :super(slotName: slotName, childrenIds: childId == null? []: [childId]);

  @override
  void insert(String id, [data]) {
    assert(childrenIds.length <= 1);
    childrenIds..clear()..add(id);
  }
  @override
  void remove(String id, [data]) {
    assert(childrenIds.first == id,
    "Tried to remove child $id, but this only contained ${childrenIds.first}");
    childrenIds.clear();
  }

  dynamic getDataForChild(String id) => null;

  Expression generateCode(Map<String, WidgetElement> allElements) {
    assert(childrenIds.length == 0 || childrenIds.length == 1);
    return CodeExpression(Code("${allElements[childrenIds[0]]?.writeCode2(allElements)}"));
  }

}

class ListChildSlot extends ChildSlot {

  ListChildSlot({@required String slotName, List<String> childrenIds})
      :super(slotName: slotName, childrenIds: childrenIds?? []);

  @override
  void insert(String id, [SlotData data]) {
    if(data == null) {
      childrenIds.add(id);
    } else {
      if(data.data == null) {
        childrenIds.add(id);
      } else {
        assert(data.data is int);
        childrenIds.insert(data.data, id);
      }
    }
  }
  @override
  void remove(String id, [data]) {
    childrenIds.remove(id);
  }

  dynamic getDataForChild(String id) {
    return childrenIds.indexOf(id);
  }
  Expression generateCode(Map<String, WidgetElement> allElements) {
    return literalList(childrenIds.map((it) => allElements[it]).map((it) => it.toExpression(allElements)));
    //return CodeExpression(Code("${allElements[childrenIds[0]]?.writeCode2(allElements)}"));
  }
}

class ExtraObjectInfo {
  final String instanceId;

  ExtraObjectInfo(this.instanceId);
}

/// The glue between the widget tree and the visual representation
///
/// This class is a shallow object which contains the current configuration.
/// It is not directly mutable, but the properties it contains are mutable therefore
/// this object is to be considered mutable.
abstract class WidgetElement {
  WidgetElement(this.id) {
    children = constructChildSlots();
  }

  bool get isRoot => false;
  String id;

  /// Should return a widget which adapts to the properties defined here
  ///
  /// The id should be passed to that widget and it should listen for changes which
  /// happen to this element
  Widget generateWidget();
  List<MProperty> get attributes;
  List<ChildSlot> children;
  List<ChildSlot> constructChildSlots();
  String get name;
  bool get hasChildSlots => children.length > 0;

  /// Indicates whether this widget element is collapsed in the widget-tree
  ///
  /// TODO This is going to be moved into the canvas later
  /// because different canvases might want to have different widgets collapsed
  /// as of now, canvases are not implemented so this is here in the meantime.
  bool isCollapsed = false;

  void removeChild(String childId);

  dynamic getDataForChild(String childId);

  bool containsChild(String childId);

  /// Data are extra information about the drag target (for example the row
  /// adds the position to insert at)
  void acceptChild(String childId, [SlotData data]);

  bool canAcceptChild(String childId, [SlotData data]) => true;

  /// This is only used for templates to make the syntax nicer.
  void tAccept(WidgetBoard b, WidgetElement child, [dynamic data]) {
    b.acceptNewChild(id, child, data);
  }

  Expression toExpression(Map<String, WidgetElement> allElements) {
    return propertyConstructor(name.replaceAll(" ", ""), attributes,
        children.where((it) => it.hasChild).toList().asMap().map((key, value) {
          return MapEntry(value.slotName, value.generateCode(allElements));
        })
    );

  }
  String writeCode2(Map<String, WidgetElement> allElements) {
    final emitter = DartEmitter();
    return toExpression(allElements).accept(emitter).toString();
  }

}



mixin SingleChildElement on WidgetElement {

  @override
  List<ChildSlot> constructChildSlots() => [SingleChildSlot(slotName: "child")];


  String get childId => childSlot.childrenIds.length == 1? childSlot.childrenIds.first: null;
  ChildSlot get childSlot => children[0];

  String get slotName => "child";

  void acceptChild(String childId, [SlotData data]) {
    childSlot.insert(childId, data);
  }

  @override
  bool containsChild(String childId) {
    return this.childId == childId;
  }

  @override
  bool canAcceptChild(String childId, [SlotData data]) => this.childId == null;

  void removeChild(String childId) {
    childSlot.remove(childId);
  }

  dynamic getDataForChild(String childId) => null;


}

mixin NoChildElementMixin on WidgetElement {

  @override
  List<ChildSlot> constructChildSlots() => [];

  @override
  List<ChildSlot> get children => [];

  @override
  void acceptChild(String childId, [data]) {
    assert(false, "$name does not want to accept children");
  }

  @override
  bool containsChild(String childId) => false;

  @override
  bool canAcceptChild(String childId, [data]) => false;

  @override
  void removeChild(String childId) {
    assert(false);
  }

  dynamic getDataForChild(String childId) => null;
}



mixin SlotChildElementMixin on WidgetElement {


  @override
  List<ChildSlot> constructChildSlots();

  /// Helper method for slots with a single child
  String findIdForSlot(String slot) {
    for(ChildSlot it in children) {
      if(it.slotName == slot) {
        assert(it.isSingleChild, "Was not single child slot");
        return it.childrenIds.length > 0? it.childrenIds[0] : null;
      }
    }
    return null;

    //assert(false, "not found $slot");
  }


  @override
  bool containsChild(String childId) {
    return children.expand((it) => it.childrenIds).contains(childId);
  }

  // TODO Don't accept until a clear widget tree slot system is ready
  // Can accept if there is only one slot tho
  @override
  bool canAcceptChild(String childId, [SlotData data]) => children.length == 1;

  @override
  void acceptChild(String childId, [SlotData data]) {

    // TODO nesting data, first which slot, then which pos

    // If no data, just put it in the first slot
    if(data == null) {
      children.first.insert(childId, data);
    } else {
      children
          .where((it) => it.slotName == data.slotName)
          .first
          .insert(childId, data);
    }
  }

  @override
  dynamic getDataForChild(String childId) {
    for(ChildSlot it in children) {
      if(it.childrenIds.contains(childId)) {
        return SlotData(
          slotName: it.slotName,
          data: it.getDataForChild(childId),
        );
      }
    }
    assert(false, "Could not find data for $childId");
  }

  @override
  void removeChild(String childId) {
    for(ChildSlot it in children) {
      if(it.childrenIds.contains(childId)) {
        it.childrenIds.remove(childId);
        return;
      }
    }
    assert(false, "Tried to remove $childId from scaffold which didn't have that child");
  }

}

