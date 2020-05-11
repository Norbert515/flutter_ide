import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/app_scope/currently_dragging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/modules/workspace/widget_board.dart';
import 'package:widget_maker_2_0/utils/utils.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widgets/at_cursor_alert.dart';
import 'package:widget_maker_2_0/widgets/global_draggable.dart';

class ItemsAndSelected {

  final int selectedPosition;
  final List<IndexedObject<WidgetElement>> items;

  ItemsAndSelected({this.selectedPosition, this.items});
}

class WidgetTree extends StatefulWidget {

  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {


  WidgetBoard get widgetBoard => AppScope.of(context).widgetBoard;
  FocusNode node = FocusNode(debugLabel: "Widget Tree");

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }


  bool isParentSelected(int index, int selectedPosition, List<IndexedObject<WidgetElement>> items) {
    // Because things can be collapsed, there can be situation where
    // the selected item is under the thing that is collapsed,
    // in that case it is safe to say it is not collapsed
    if(selectedPosition >= items.length)
      return false;
    if(selectedPosition == null || selectedPosition < 0) return false;
    IndexedObject<WidgetElement> toTest = items[index];
    IndexedObject<WidgetElement> selected = items[selectedPosition];
    if(toTest.index <= selected.index) return false;
    for(int i = selected.index - 1; i >= 0; i--) {
      if(toTest.treePart[i] != selected.treePart[i])
        return false;
    }
    return true;
  }

  ValueStream<ItemsAndSelected> get _theStream => widgetBoard.widgetElementsFlatAndCurrentlySelectedPosition
    .map((it) {
      return ItemsAndSelected(
        items: it.items,
        selectedPosition: it.items.indexWhere((it2) => it2.object.id == it.currentlySelected)
      );
    }).shareValue();

  @override
  Widget build(BuildContext context) {
    return FocusArea(
      outline: false,
      node: node,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Widget-Tree", style: Theme.of(context).textTheme.title,),
          ),
          Expanded(
            child: StreamBuilder<ItemsAndSelected>(
              stream: _theStream,
              initialData: _theStream.value,
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if(!snapshot.hasData)
                  return SizedBox();
                var items = snapshot.requireData.items;
                var selectedPosition = snapshot.requireData.selectedPosition;
                return SelectableList(
                  itemCount: items.length,
                  itemHeight: 30,
                  itemsBeforeScroll: 3,
                  selectedIndex: selectedPosition,
                  focusNode: node,
                  onSelectChange: (it) {
                    var id = items[it].object.id;
                    widgetBoard.setSelected(id);

                  },
                  itemBuilder: (context, index) {
                    return _WidgetItem(
                      element: items[index],
                      selected: selectedPosition == index,
                      parentSelected: isParentSelected(index, selectedPosition, items),
                      onToggle: () {
                        AppScope.of(context).widgetBoard.toggleCollapsed(items[index].object.id);
                      },
                      onTap: () {
                        AppScope.of(context).widgetBoard.setSelected(items[index].object.id);
                        //FocusScope.of(context).requestFocus(node);
                      },
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetItem extends StatelessWidget {


  const _WidgetItem({Key key, this.element, this.onTap, this.onToggle, this.selected, this.parentSelected})
      : assert(!(selected && parentSelected)) ,super(key: key);

  final IndexedObject<WidgetElement> element;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final bool selected;
  final bool parentSelected;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Draggable(
        // TODO code duplication with base.dart
        onDragStarted: () {
          Provider.of<CurrentlyDraggingState>(context).setDragging(true);
        },
        onDragEnd: (details) {
          if(!details.wasAccepted) {
            showDidNotAccept(context);
          }
          Provider.of<CurrentlyDraggingState>(context).setDragging(false);
        },
        data: element.object.id,
        feedback: Container(
          padding: EdgeInsets.only(left: (element.index * 8).toDouble(), top: 4),
          child: Text(element.object.name, style: Theme.of(context).textTheme.body1,),
        ),
        child: GlobalDragTarget<String>(
          onWillAccept: (it) => element.object.canAcceptChild(it),
          onAccept: (childId) {
            // TODO implement data for her - for example lists need to pass index data
            AppScope.of(context).widgetBoard.acceptChild(element.object.id, childId, null);
          },
          builder: (context, accepted, rejected) {
            return InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.centerLeft,
                color: selected || accepted.isNotEmpty? Colors.blue : parentSelected?
                Colors.blue.withOpacity(0.1): null,
                padding: EdgeInsets.only(left: (element.index * 8).toDouble() + 8 /* Normal Padding */),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: onToggle,
                      child: element.object.hasChildSlots && element.object.children.expand((it) => it.childrenIds).isNotEmpty?
                        Icon(element.object.isCollapsed? Icons.arrow_drop_up : Icons.arrow_drop_down):
                        SizedBox(width: IconTheme.of(context).size,),
                    ),
                    Text(element.object.name, style: Theme.of(context).textTheme.body1,),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

  }
}