import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_visual_builder/editor/editor_widget.dart';
import 'package:ide/client/client.dart';
import 'package:ide/logic/property_bloc.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/text_editor/basic.dart';
import 'package:ide/ui/widget_editors/common_editors.dart';
import 'package:provider/provider.dart';

// TODO move out of here
VisualClient serverClient;



class HomePage extends StatefulWidget {

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  bool inited = false;

  PropertyBloc propertyBloc;

  @override
  void initState(){
    super.initState();
    init();
  }


  void init() async {
    await Future.delayed(Duration(seconds: 2));
    serverClient = VisualClient(ServerClient(ClientChannel("localhost", port: 50051, options: ChannelOptions(credentials: ChannelCredentials.insecure()))));
    serverClient.init();
    propertyBloc = PropertyBloc(serverClient);
    setState(() {
      inited = true;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(child: VisualEditor()),
              inited? PropertySettingSection(propertyBloc: propertyBloc,): SizedBox(),
            ],
          ),
        ),
        Expanded(child: inited? TextEditor() : SizedBox()),
      ],
    );
  }

}

class PropertySettingSection extends StatelessWidget {


  const PropertySettingSection({Key key, this.propertyBloc}) : super(key: key);

  final PropertyBloc propertyBloc;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 400,
      height: double.infinity,
      child: StreamBuilder<Widget>(
        stream: propertyBloc.editor,
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);

          return Material(
            child: snapshot.requireData,
          );
        },
      ),
    );
  }
}

