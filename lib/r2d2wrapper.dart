import 'package:widget_maker_2_0/widget_elements/generated/registry.dart';

import 'modules/workspace/workspace_page/bars/palette/palette_bar.dart';


/// Wrapper around R2D2 which provides the widget elements which are possible
/// to instantiate
///
/// Is a singleton
class R2D2Wrapper {
  static R2D2Wrapper _instance;

  factory R2D2Wrapper() {
    if(_instance == null) {
      _instance = R2D2Wrapper._();
    }
    return _instance;
  }


  R2D2Wrapper._(): this.r2d2 = R2D2();


  final R2D2 r2d2;

  List<PaletteItem> get allItems => r2d2.allItems..addAll(_addedItems);

  Map<String, List<PaletteItem>> get categories => r2d2.categories..["custom"] = _addedItems;

  List<PaletteItem> _addedItems = [];

  void addPaletteItem(PaletteItem item) {
    assert(item.categories.length == 1 && item.categories[0] == "custom", "Needs to be a custom category");
    _addedItems.add(item);
  }
}