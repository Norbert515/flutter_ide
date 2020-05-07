import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:uuid/uuid.dart';

typedef WidgetElementGenerator = WidgetElement Function(String id);

/// An item which is instantiable
///
/// PaletteItems are shown in the quick access menu and the widget overview.
class PaletteItem {

  PaletteItem({this.categories = const ["Other"], this.name, this.icon, this.generator, this.widget});

  /// The name of the item
  ///
  /// Will be displayed when selecting it
  final String name;

  /// The visual icon representation of the widget
  final IconData icon;

  /// A generator for a widget element.
  ///
  /// It takes a string and returns a new WidgetElement in its preconfigured state
  final WidgetElementGenerator generator;

  /// Visual representation when selecting widget
  final Widget widget;

  /// A list of categories the widget belongs to. Used for grouping
  final List<String> categories;

  /// The visual representation of the widget
  Widget get visualRepresentation => widget?? Icon(icon);

  WidgetElement get widgetElement => generator(Uuid().v1());


}

class PaletteItemVisualFeedback extends StatelessWidget {

  final PaletteItem paletteItem;

  const PaletteItemVisualFeedback({Key key, this.paletteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200, child: Material(color: Colors.transparent, child: PaletteItemVisual(paletteItem: paletteItem,)));
  }
}

class PaletteItemVisual extends StatelessWidget {

  final PaletteItem paletteItem;

  const PaletteItemVisual({Key key, this.paletteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(paletteItem.icon),
      title: FittedBox(
        child: Text(paletteItem.name),
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
