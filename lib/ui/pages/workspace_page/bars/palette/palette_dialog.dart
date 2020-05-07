import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/r2d2wrapper.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/bars/palette/palette_bar.dart';
import 'package:widget_maker_2_0/ui/utils/desktop_scroll_behavior.dart';

Future<PaletteItem> showPaletteDialog(BuildContext context) {
  return showDialogAndRestoreFocus(context: context, builder: (context) {
    return PaletteDialog();
  });
}

class PaletteDialog extends StatefulWidget {
  @override
  _PaletteDialogState createState() => _PaletteDialogState();
}

class _PaletteDialogState extends State<PaletteDialog> {

  R2D2Wrapper r2d2 = R2D2Wrapper();

  // In one single scrollable
  /*
  ScrollConfiguration(
          behavior: DesktopBehavior(),
          child: CustomScrollView(
            slivers: r2d2.categories.keys.expand<Widget>((key) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(key, style: Theme.of(context).textTheme.headline,),
                  ),
                ),
                getGridViewForCategory(key)
              ];
            }).toList(),
          ),
        ),

   */

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: DefaultTabController(
        length: r2d2.categories.length,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: constraints.loosen(),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: Center(
                        child: TabBar(
                          tabs: r2d2.categories.keys.map((category) {
                            return Tab(
                              text: category,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: TabBarView(children: r2d2.categories.keys.map((category) {
                          return ScrollConfiguration(
                            behavior: DesktopBehavior(),
                            child: GridView.extent(
                              maxCrossAxisExtent: 300,
                              children: r2d2.categories[category].map((it) {
                                return _WidgetItem(
                                  item: it,
                                  onTap: () {
                                    Navigator.of(context).pop(it);
                                  },
                                );
                              }).toList(),
                            )
                          );
                        }).toList()),
                      ),
                    )
                  ]
                )
              ),
            );
          }
        ),
      ),
    );
  }

  Widget getGridViewForCategory(String category) {
    return SliverGrid.extent(
      maxCrossAxisExtent: 300,
      children: r2d2.categories[category].map((it) {
        return _WidgetItem(
          item: it,
          onTap: () {
            Navigator.of(context).pop(it);
          },
        );
      }).toList(),
    );
  }
}


class _WidgetItem extends StatelessWidget {

  final PaletteItem item;
  final VoidCallback onTap;

  const _WidgetItem({Key key, this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white)
          ),
          child: Column(
            children: <Widget>[
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: item.visualRepresentation),
              )),
              Text(item.name),
            ],
          ),
        ),
      ),
    );
  }
}

