import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:widget_maker_2_0/modules/code_generation/code_generator.dart';
import 'package:widget_maker_2_0/modules/workspace/board_flattern.dart';
import 'package:widget_maker_2_0/modules/workspace/workspace_page/bars/palette/palette_bar.dart';
import 'package:widget_maker_2_0/properties/meta_properties.dart';
import 'package:widget_maker_2_0/r2d2wrapper.dart';
import 'package:widget_maker_2_0/utils/utils.dart';
import 'package:widget_maker_2_0/utils/position_calculator.dart';
import 'package:widget_maker_2_0/widget_elements/base/instanced_widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/base/literal_widget.dart';
import 'package:widget_maker_2_0/widget_elements/base/meta.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';

import 'models.dart';

typedef ElementUpdater = void Function(WidgetElement element);
typedef UpdateWidget = void Function();
typedef UpdateLayout = void Function();


class Selection {
  final String id;
  final String canvasId;

  const Selection({
    @required this.id,
    @required this.canvasId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Selection &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              canvasId == other.canvasId
          );

  @override
  int get hashCode =>
      id.hashCode ^
      canvasId.hashCode;

  Selection copyWith({
    String id,
    String canvasId,
  }) {
    return new Selection(
      id: id ?? this.id,
      canvasId: canvasId ?? this.canvasId,
    );
  }

}

/// Class which contains all widgets on the screen for this project
///
/// It holds all different screens, widgets, instances etc.
///
/// [notifyListeners] is called
class WidgetBoard with ChangeNotifier {

  factory WidgetBoard({CanvasSize canvasSize}) {

    var rootKey = "root-${Uuid().v1()}";
    // TODO change to canvas
    var root;
    if(canvasSize != null) {
      root = CanvasElement(
          id: rootKey,
          canvasSize: canvasSize
      );
    } else {
      root = CanvasElement(
          id: rootKey,
      );
    }


    return WidgetBoard.b(
      WidgetBoardFlatterner(),
      rootKey,
      root
    );
  }

  // TODO remove this root once refactorings are done
  WidgetBoard.b(this._flatterner, this.rootKey, CanvasElement root) {

    _allWidgets[root.id] = root;

    _rootCanvasRelation[root.id] = root.id;
    // In the meantime make both TODO
    _canvases[root.id] = root;

    _flatterner.widgetBoard = this;
  }

  final ICodeGenerator codeGenerator = SingleFileCodeGenerator();

  final WidgetBoardFlatterner _flatterner;

  // TODO decide which methods are elementary, meaning the directly interact with the maps
  // and which just use those maps to implement various features
  // right now its a mix of everyone manages stuff and uses stuff.

  /// Map of canvases, ID -> Canvas
  ///
  /// Canvases are also included in [_allWidgets]
  /// TODO root element needs to be refactored to canvas API
  final Map<String, CanvasElement> _canvases = Map();
  Map<String, CanvasElement> get canvases => _canvases;

  // TODO make this better?!
  Widget generateCanvasWidget(String id) {
    return _allWidgets[id].generateWidget();
  }


  final Map<String, WidgetElement> _allWidgets = Map();
  Map<String, WidgetElement> get allWidgets => _allWidgets;

  /// Updates called when a widgetElement changes [?]
  final Map<String, List<UpdateWidget>> _updates = Map();

  // DEPRICATED; FIND A BETTER WAY
  // TODO use nested changenotifiers
  final List<UpdateLayout> _layoutUpdates = List();


  // I think I prefere streams
  final PublishSubject<void> _onTopLevelChange = PublishSubject();

  /// Called whenever a top level element, such as a canvas changes
  /// This is separate because it is the glow between the normal widget system
  /// and this widgetElement system which has updates built in
  Stream<void> get onTopLevelChangeStream => _onTopLevelChange.stream;


  // This is a BehaviorSubject because we'd like to have an update at the very beginngin
  final BehaviorSubject<void> _onChangeAnything = BehaviorSubject.seeded(null);

  /// Map from child to parent
  final Map<String, String> _childParentRelation = Map();

  Stream<List<IndexedObject<WidgetElement>>> get
  allWidgetElementsForSelectedCanvasFlatStream =>
    _onChangeAnything.map((_) => getAllWidgetElementsFlat(rootKey));


  Stream<WidgetElementsFlatAndCurrentlySelectedPosition> get
    widgetElementsFlatAndCurrentlySelectedPosition =>
      Rx.combineLatest2(currentlySelected, _onChangeAnything, (selected, _) {
        return WidgetElementsFlatAndCurrentlySelectedPosition(
          currentlySelected: selected,
          items: getAllWidgetElementsFlat(_rootCanvasRelation[selected]),
        );
      });
  // TODO share value?


  ValueStream<WidgetElement> get currentSelectedCanvasElementStream =>
      currentlySelected.map((id) {
        return _allWidgets[_rootCanvasRelation[id]];
      }).shareValueSeeded(_allWidgets[_rootCanvasRelation[currentlySelectedValue]]);


  /// Maps from an ID of a WidgetElement to the ID of the corresponding CanvasElement
  ///
  /// Each canvas maps onto itself
  Map<String, String> _rootCanvasRelation = Map();

  @Deprecated("Moving to canvas")
  WidgetElement getRootElement() => getWidgetElement(rootKey);
  WidgetElement getWidgetElement(String id) {
    return _allWidgets[id];
  }

  @Deprecated("Moving to canvas API")
  final String rootKey;
  @Deprecated("Moving to canvas")
  WidgetElement get rootWidgetElement => _allWidgets[rootKey];

  // TODO need a way to now widgetElement -> CanvasId


  List<IndexedObject<WidgetElement>> getAllWidgetElementsFlat(String canvasId) =>
      _flatterner.getAllWidgetElementsFlat(canvasId);


  /// Add a [WidgetElement] to the pool of widget elements
  /// but do not add any sort of relation yet.
  void addChild(WidgetElement element) {
    _allWidgets[element.id] = element;
  }

  /// Remove a [WidgetElement] from the pool of widget elements
  /// does not change any relations
  void removeChild(String id) {
    _allWidgets.remove(id);
  }

  // TODO add dispose
  // ignore: close_sinks
  BehaviorSubject<String> _currentlySelectedController = BehaviorSubject.seeded(null);
  Stream<String> get currentlySelected => _currentlySelectedController.stream;

  /// The id of the currently selected widget element
  String currentlySelectedValue;

  /// Registers a callback to be called when a given WidgetElement changes
  void registerUpdate(String id, UpdateWidget onUpdate) {
    var list = _updates[id];
    if (list == null) {
      list = [onUpdate];
    } else {
      list.add(onUpdate);
    }
    _updates[id] = list;
  }

  void removeUpdate(String id, UpdateWidget onUpdate) {
    _updates[id]?.remove(onUpdate);
  }


  void registerLayoutUpdate(UpdateLayout onUpdate) {
    _layoutUpdates.add(onUpdate);
  }

  void removeLayoutUpdate(UpdateLayout onUpdate) {
    _layoutUpdates.remove(onUpdate);
  }



  /// Return the widget element even if it is only in the preRegistered
  ///
  /// This is useful for visual display before actually accepting the child
  /// for example the different lists use this to enable reordering
  /// [DEPRECATED]
  @Deprecated("Isn't needed anymore as preregistered is deleted")
  WidgetElement getWidgetElementFromAnySource(String id) {
    return _allWidgets[id];
  }

  void wrap(String toWrap, WidgetElement wrapper) {

    // parentId
    // | toWrap
    //
    // to
    //
    // parentId
    // | wrapper
    //   | toWrap
    var parentId = _childParentRelation[toWrap];

    // Save data and disconnect parent
    // TODO check this if this works after refactoring, especially wrapping things inside a list
    var parentData = _allWidgets[parentId].getDataForChild(toWrap);
    _allWidgets[parentId].removeChild(toWrap);

    // Register wrapper
    _allWidgets[wrapper.id] = wrapper;


    _childParentRelation[toWrap] = wrapper.id;
    _childParentRelation[wrapper.id] = parentId;

    wrapper.acceptChild(toWrap);


    _allWidgets[parentId].acceptChild(wrapper.id, parentData);

    // We are adding a new element to the system, it needs to registered in the relation
    // It has the same parent as the wrapper
    _rootCanvasRelation[wrapper.id] = _rootCanvasRelation[toWrap];
    setSelected(wrapper.id);
    notifyUpdate(parentId);

  }

  void toggleCollapsed(String id) {
    _allWidgets[id].isCollapsed = !_allWidgets[id].isCollapsed;
    notifyUpdate(id);
  }

  void setSelected(String id) {
    _currentlySelectedController.add(id);
    currentlySelectedValue = id;
  }

  bool hasChildren(String id) {
    return _allWidgets[id].children.isNotEmpty && _allWidgets[id].children.any((childId) => childId != null);
  }

  void replaceWithChildren(String id) {
    assert(canMerge(id));

    var parent = _allWidgets[_childParentRelation[id]];
    assert(_allWidgets[id].children.length == 1);
    assert(_allWidgets[id].children[0].childrenIds.length == 1);
    var child = _allWidgets[_allWidgets[id].children[0].childrenIds[0]];

    removeWidget(id, recursive: false);

    parent.acceptChild(child.id);

    _childParentRelation[child.id] = parent.id;

    notifyUpdate(parent.id);
  }

  /// Only one slot
  bool canMerge(String id) {
    return _allWidgets[id].children.length == 1 && _allWidgets[_childParentRelation[id]]?.children?.length == 1;
  }

  /// Removes a child
  void removeWidget(String id, {bool recursive = true}) {
    assert(id != null, "Id was null");

    // Cannot remove the root
    if (id == rootKey) return;

    assert(_allWidgets.containsKey(id), "ID: $id is not found");

    if (!_allWidgets.containsKey(id)) return;

    if (recursive) {
      _allWidgets[id].children.forEach((slot) {
        if (slot.hasChild) {
          // Doing this so there will be no concurrent iterable modification
          // as this method calls [_allWidgets[parentId].removeChild(id)]
          List<String> childrenToRemove = List.from(slot.childrenIds);
          childrenToRemove.forEach((id) => removeWidget(id));
        }
      });
    }
    if (currentlySelectedValue == id) {
      setSelected(_childParentRelation[id]);
    }

    _allWidgets.remove(id);
    _rootCanvasRelation.remove(id);

    // Remove from parent
    String parentId = _childParentRelation[id];
    if (parentId != null) {
      _childParentRelation.remove(id);
      _allWidgets[parentId].removeChild(id);
      _updates[parentId]?.forEach((it) => it());
    }

    notifyListeners();
  }


  void acceptNewChild(String parentId, WidgetElement child, [SlotData data]) {
    _allWidgets[child.id] = child;
    _rootCanvasRelation[child.id] = _rootCanvasRelation[parentId];
    acceptChild(parentId, child.id, data);
  }


  /// If the child is already somewhere else, this will reparent it
  void acceptChild(String parentId, String childId, [SlotData data]) {

    // get current parent
    var oldParent = _childParentRelation[childId];
    if (oldParent != null) {
      var oldParentElement = _allWidgets[oldParent];
      oldParentElement.removeChild(childId);
      notifyUpdate(oldParent);
    }

    _childParentRelation[childId] = parentId;
    _allWidgets[parentId].acceptChild(childId, data);

    _rootCanvasRelation[childId] = _rootCanvasRelation[parentId];

    // Select accepted child
    setSelected(childId);
    notifyUpdate(parentId);
  }


  /// This method is like a plate of pizza that people forgot about
  ///
  /// It sucks.
  ///
  /// No idea at what scope this is called and if all the updates are necessary
  void notifyUpdate(String id, {affectsLayout = true}) {
    _updates[id]?.forEach((it) => it());
    notifyListeners();
    _layoutUpdates.forEach((it) => it());

    _onChangeAnything.add(null);
    if(_allWidgets[id].isRoot) {
      // If the updated element (such as the CanvasElement) is root,
      // we'd like to emit that a root change has happend
      _onTopLevelChange.add(null);
    }
  }

  /// Updates a given element
  void update(String id, ElementUpdater elementUpdater) {
    elementUpdater(_allWidgets[id]);
    notifyUpdate(id, affectsLayout: false);
  }


  void addCanvas(String name, CanvasSize canvasSize) {
    // TODO implement
    PositionCalculator positionCalculator = PositionCalculator();

    CanvasElement canvas = CanvasElement(
      id: Uuid().v1(),
      canvasSize: canvasSize,
      position: positionCalculator.getPosition(_canvases.keys.map((key) {
        return PositionedObject(
          position: _canvases[key].position.value,
          size: _canvases[key].canvasSize.value.size,
        );
      }).toList(), canvasSize.size)
    );

    _canvases[canvas.id] = canvas;
    // TODO only for now as the two system exist
    _allWidgets[canvas.id] = canvas;

    _rootCanvasRelation[canvas.id] = canvas.id;


    LiteralWidgetElement widget = LiteralWidgetElement(
      id: Uuid().v1(),
      name: name?? "NoName",
    );
    acceptNewChild(canvas.id, widget);


    // We added a top level element, update the display
    _onTopLevelChange.add(null);
  }

  // TODO more options for customization
  void duplicateLiteralWidgetWithConfiguration(String literalWidgetId, CanvasSize canvasSize) {

    PositionCalculator positionCalculator = PositionCalculator();

    CanvasElement canvas = CanvasElement(
      id: Uuid().v1(),
      canvasSize: canvasSize,
      position: positionCalculator.getPosition(_canvases.keys.map((key) {
        return PositionedObject(
          position: _canvases[key].position.value,
          size: _canvases[key].canvasSize.value.size,
        );
      }).toList(), canvasSize.size)
    );

    _canvases[canvas.id] = canvas;
    // TODO only for now as the two system exist
    _allWidgets[canvas.id] = canvas;

    _rootCanvasRelation[canvas.id] = canvas.id;

    _childParentRelation[literalWidgetId] = canvas.id;
    _allWidgets[canvas.id].acceptChild(literalWidgetId);

    _rootCanvasRelation[literalWidgetId] = canvas.id;

    // Select accepted child
    setSelected(literalWidgetId);

    // We added a top level element, update the display
    _onTopLevelChange.add(null);

  }

  /// TODO refactor this to nicers system
  LiteralWidgetElement getFirstLiteralWidgetElementAncestor(String id) {
    WidgetElement element = getWidgetElementFromAnySource(id);
    while(element is! LiteralWidgetElement) {
      var parentId = _childParentRelation[element.id];
      element = getWidgetElementFromAnySource(parentId);
    }

    return element;
  }

  InstancedWidgetElement getFirstInstancedWidgetElementAncestor(String id) {
    // TODO
    return null;
  }

  ///
  void makeInstanceable(String literalWidgetId) {

    LiteralWidgetElement widgetElement = _allWidgets[literalWidgetId];


    // When adding a new canvas we'd like it to be instantiable
    // Is a singleton
    // TODO cleanup singleton
    R2D2Wrapper wrapper = R2D2Wrapper();
    wrapper.addPaletteItem(PaletteItem(
      categories: ["custom"],
      name: widgetElement.name,
      icon: Icons.ac_unit,
      widget: widgetElement.generateWidget(),
      generator: (id) {
        return InstancedWidgetElement(
          id, widgetElement.name, literalWidgetId, () {
          var props = widgetElement.addedProperties.map((prop) => prop.copy()).toList();
          /*props.forEach((it) {
            it.valueGetter = () {

            };
          });*/
          return props;
        },
        );
      },
    ));

  }

  void removeCanvas(String canvasId) {

  }


  String getLayoutCode() {
    return codeGenerator.generateCode(canvases, _allWidgets);
  }







}

