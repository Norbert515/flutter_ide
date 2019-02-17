import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:ide/business_logic/property_bloc.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/widgets/dependencies/property_editor_provider.dart';
import 'package:ide/widgets/property_editor.dart';
import 'package:ide/widgets/text_editor/basic.dart';
import 'package:provider/provider.dart';
import 'package:flutter_visual_builder/pages/editor_widget.dart';
import 'package:flutter_visual_builder/widgets/widget_palette/palette.dart';
import 'package:flutter_visual_builder/business_logic/global_settings/global_settings.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return PropertyEditorProvider(
      child: PlaceholderManager(
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
      ),
    );
  }
}

class EditingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

