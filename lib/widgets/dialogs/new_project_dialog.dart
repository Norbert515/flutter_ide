import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/modules/theme.dart';
import 'package:widget_maker_2_0/templates/hello_world_app.dart';
import 'package:widget_maker_2_0/templates/new_templates.dart';

import 'general.dart';


Future showNewProjectDialog(BuildContext context) {
  return showDialogAndRestoreFocus(context: context, builder: (context) => NewProjectDialog());
}

class NewProjectDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8),
        color: MyTheme.of(context).background16dp,
        width: 600,
        height: 500,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
                child: Text("Widget Maker", style: Theme.of(context).textTheme.display1,)
              )
            ),
            Expanded(
              flex: 7,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Start from scratch", style: Theme.of(context).textTheme.title,),
                        SizedBox(height: 8,),
                        DialogOption(
                          leading: Icon(Icons.phone_android),
                          text: "Pixel 2",
                          onTap: () {
                            AppScope.of(context).overrideWidgetBoard(getPixelWidgetBoard());
                            Navigator.of(context).pop();
                          },
                        ),
                        DialogOption(
                          leading: Icon(Icons.desktop_windows),
                          text: "Desktop",
                          onTap: () {
                            AppScope.of(context).overrideWidgetBoard(getDesktopWidgetBoard());
                            Navigator.of(context).pop();
                          },
                        ),
                        Spacer(),
                        Text("Size is changable anytime by selecting the \"canvas\" element", textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Start from template", style: Theme.of(context).textTheme.title,),
                        SizedBox(height: 8,),
                        DialogOption(
                          text: "Hello Word",
                          leading: Icon(Icons.airport_shuttle),
                          onTap: (){
                            AppScope.of(context).overrideWidgetBoard(helloWorldTemplate());
                            Navigator.of(context).pop();
                          },
                        ),
                        DialogOption(
                          text: "Login Screen 1",
                          leading: Icon(Icons.airport_shuttle),
                          onTap: (){
                            AppScope.of(context).overrideWidgetBoard(testTemplate());
                            Navigator.of(context).pop();
                          },
                        ),
                        DialogOption(
                          text: "Hello Word",
                          leading: Icon(Icons.airport_shuttle),
                          onTap: (){
                            AppScope.of(context).overrideWidgetBoard(testTemplate());
                            Navigator.of(context).pop();
                          },
                        ),
                        DialogOption(
                          leading: Icon(Icons.card_giftcard),
                          text: "Contact Card",
                          onTap: () {
                            AppScope.of(context).overrideWidgetBoard(getCardWidgetBoard());
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
