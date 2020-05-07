import 'package:uuid/uuid.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:widget_maker_2_0/r2d2wrapper.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/bars/palette/palette_bar.dart';
import 'package:widget_maker_2_0/ui/theme.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/ui/utils/first_build_focus.dart';

typedef WidgetElementFilter = bool Function(WidgetElement e);

Future<PaletteItem> quickChooseWidgetElement(BuildContext context, {WidgetElementFilter filter}) {
  return showDialogAtCursor<PaletteItem>(
    context: context,
    size: Size(400,300),
    builder: (context) => QuickWidgetAccessDialog(
      filter: filter,
    ),
  );
}

class QuickWidgetAccessDialog extends StatefulWidget {


  final WidgetElementFilter filter;

  const QuickWidgetAccessDialog({Key key, this.filter}) : super(key: key);

  @override
  _QuickWidgetAccessDialogState createState() => _QuickWidgetAccessDialogState();
}

class _QuickWidgetAccessDialogState extends State<QuickWidgetAccessDialog> {


  final controller = TextEditingController();
  String filterString = "";

  int selectedIndex;
  int get shadowSelection => selectedIndex?? 0;

  FocusNode listFocus = FocusNode(debugLabel: "List Focus");
  FocusNode textFocus = FocusNode(debugLabel: "Text Focus");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(textFocus);
    listFocus.attach(context);
    textFocus.attach(context);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filterString = controller.text;
      });
    });
  }

  List<PaletteItem> get items => r.allItems
      .where((item) => item.name.toLowerCase().contains(filterString.toLowerCase()))
      .where(widget.filter == null? (it) => true : (it) => widget.filter(it.widgetElement))
      .toList();

  R2D2Wrapper r = R2D2Wrapper();


  bool onEnter() {
    if(selectedIndex != null) {
      Navigator.pop(context, items[selectedIndex]);
    } else {
      if (items.length == 1)
        Navigator.pop(context, items.single);
    }
    FocusScope.of(context).requestFocus(listFocus);
    return false;
  }


  bool onEscape() {
    Navigator.of(context).pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: InteractionKeyboard(
        onEscape: onEscape,
        onDown: () {
          FocusScope.of(context).requestFocus(listFocus);
          return false;
        },
        onUp: () {
          FocusScope.of(context).requestFocus(listFocus);
          return false;
        },
        onEnter: onEnter,
        child: Container(
          color: MyTheme.of(context).background16dp,
          width: 400,
          height: 300,
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                focusNode: textFocus,
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: "Search for a widget..."
                ),
              ),
              Divider(
                height: 0,
              ),
              Expanded(
                child: SelectableList(
                  focusNode: listFocus,
                  itemCount: items.length,
                  itemHeight: 32,
                  selectedIndex: selectedIndex,
                  onSelectChange: (it) {
                    setState(() {
                      selectedIndex = it;
                    });
                  },
                  itemsBeforeScroll: 2,
                  onEnter: onEnter,
                  onEscape: () => onEscape(),
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    var it = items[index];
                    return _QuickAccessPaletteItemWidget(
                      paletteItem: it,
                      key: ObjectKey(it),
                      onTap: () {
                        selectedIndex = index;
                        onEnter();
                      },
                      selected: selectedIndex == index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAccessPaletteItemWidget extends StatelessWidget {

  const _QuickAccessPaletteItemWidget({Key key, this.paletteItem, this.onTap, this.selected}) : super(key: key);

  final PaletteItem paletteItem;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: selected? MyTheme.of(context).selectedColor: null,
        height: 32,
        child: Row(
          children: <Widget>[
            Icon(paletteItem.icon),
            SizedBox(width: 8,),
            Expanded(
              child: Text(paletteItem.name),
            ),
          ],
        ),

      ),
    );
  }
}
