import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:widget_maker_2_0/ui/widgets/dialogs/quick_widget_access_dialog.dart';
import 'package:widget_maker_2_0/ui/utils/routes.dart';

class ConfigurationBar extends StatefulWidget {
  @override
  _ConfigurationBarState createState() => _ConfigurationBarState();
}

class _ConfigurationBarState extends State<ConfigurationBar> {

  String id;
  WidgetBoard boardWidget;
  StreamSubscription subscription;
  FocusNode node = FocusNode(debugLabel: "Configuration Bar");
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    boardWidget = AppScope.of(context).widgetBoard;

    id = boardWidget.currentlySelectedValue;
    boardWidget.registerUpdate(id, refresh);

    if(subscription != null) {
      subscription.cancel();
    }
    subscription = boardWidget.currentlySelected.listen((it) {
      boardWidget.removeUpdate(id, refresh);
      id = it;
      boardWidget.registerUpdate(it, refresh);

      _navigatorKey.currentState.pushReplacement(NoTransitionRoute(
        builder: (context) {
          return id == null? buildEmpty(context): buildPage(context);
        }
      ));
      setState(() {});
    });
  }


  @override
  void dispose() {
    boardWidget.removeUpdate(id, refresh);
    subscription.cancel();
    super.dispose();
  }

  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "home",
      key: _navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        if(settings.name == "home")
          return MaterialPageRoute(
            builder: (context) => id == null? buildEmpty(context): buildPage(context)
          );
        return null;
      },
    );
  }


  Widget buildPage(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Text(
          boardWidget.getWidgetElement(id).name,
          style: Theme.of(context).textTheme.title,
        ),
        Divider(),
        Row(
          children: <Widget>[
            if(!boardWidget.getWidgetElement(id).isRoot)
              Expanded(
                child: OutlineButton(
                  child: Text("Remove"),
                  onPressed: () {
                    boardWidget.removeWidget(id);
                  },
                ),
              ),
            if(!boardWidget.getWidgetElement(id).isRoot)
              Expanded(
                child: OutlineButton(
                  child: Text("Wrap"),
                  onPressed: () async {
                    var it = await quickChooseWidgetElement(context, filter: (WidgetElement element) {
                      return element.children.length != 0;});
                    if(it != null) {
                      boardWidget.wrap(id, it.widgetElement);
                    }
                  },
                ),
              ),
            if (boardWidget.canMerge(id) && !boardWidget.getWidgetElement(id).isRoot)
               Expanded(
                child: OutlineButton(
                  child: Text("Replace with children", style: TextStyle(fontSize: 10),),
                  onPressed: () {
                    boardWidget.replaceWithChildren(id);
                  },
                ),
              ),
          ],
        ),
        buildList(context),
      ],
    );
  }

  Widget buildEmpty(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Property Editor",
            style: Theme.of(context).textTheme.title,
          ),
          Expanded(
            child: Center(
              child: Text(
                "Select a widget",
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return Column(
      key: ObjectKey(id),
      children: boardWidget.getWidgetElement(id)?.attributes?.map((it) => it.getChanger(context, id))?.map((it) {
        return it;
      })?.toList() ?? [],
    );
  }
}
