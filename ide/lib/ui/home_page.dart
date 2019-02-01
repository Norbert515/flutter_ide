import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/global_settings/global_settings.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette.dart';
import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_visual_builder/editor/editor_widget.dart';
import 'package:ide/client/client.dart';
import 'package:ide/logic/property_bloc.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/text_editor/basic.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return PlaceholderManager(
      child: Material(
        color: IDETheme.of(context).darkerBackground,
        child: Row(
          children: <Widget>[
            WidgetPalette(),
            Expanded(child: EditingSection()),
            PropertySettingSection(),
          ],
        ),
      ),
    );
  }
}

class EditingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("REBuild");
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Toggle placeholders", style: IDETheme.of(context).propertyChangerTheme.propertyContainer,),
                  Switch(value: Provider.of<bool>(context), onChanged: (it) {
                    PlaceholderManagerState.of(context).setShowing(it);
                  }),
                ],
              ),
              Expanded(child: TextEditor()),
            ],
          )),
          Expanded(
            child: Container(
              width: double.infinity,
              color: IDETheme.of(context).darkerBackground,
            ),
          ),
          VisualEditor(),
          Expanded(child: WidgetTrash()),
        ],
      ),
    );
  }
}

class PropertySettingSection extends StatelessWidget {


  const PropertySettingSection({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 400,
      height: double.infinity,
      child: StreamBuilder<Widget>(
        stream: Provider.of<PropertyBloc>(context).editor,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            if(snapshot.error is Error) {
              Error error = snapshot.error;
              print("Error $error \n ${error.stackTrace}");
            }
            print("Error ${snapshot.error}");

          }
          if(!snapshot.hasData) {
            return Material(
              color: IDETheme
                        .of(context)
                        .lightBackground,
              child: Center(
                  child: Text("Select something", style: IDETheme.of(context).propertyChangerTheme.propertyContainer,)
              ),
            );
          }

          return Material(
            child: snapshot.requireData,
          );
        },
      ),
    );
  }
}

class WidgetTrash extends StatefulWidget {
  @override
  WidgetTrashState createState() {
    return new WidgetTrashState();
  }
}

class WidgetTrashState extends State<WidgetTrash> {


  bool acceptingTrash = false;


  @override
  Widget build(BuildContext context) {
    return DragTarget<VisualStatefulWidget>(
      onWillAccept: (_) {
        setState(() {
          acceptingTrash = true;
        });
        return true;
      },
      onAccept: (it) {
        Provider.of<PropertyBloc>(context).removedIds.add(it.id);
        setState(() {
          acceptingTrash = false;
        });
      },
      onLeave: (_) {
        setState((){
          acceptingTrash = false;
        });
      },
      builder: (context, one, two) {
        return Center(
          child: Icon(Icons.delete, color:
            acceptingTrash? IDETheme.of(context).deleteColor : IDETheme.of(context).fontColor,),
        );
      },
    );
  }
}

