import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette.dart';
import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_visual_builder/editor/editor_widget.dart';
import 'package:ide/client/client.dart';
import 'package:ide/logic/property_bloc.dart';
import 'package:ide/ui/text_editor/basic.dart';

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
    return Row(
      children: <Widget>[
        WidgetPalette(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: VisualEditor(),
              ),
              Divider(),
              Expanded(flex: 1, child: inited? TextEditor() : SizedBox()),
            ],
          ),
        ),
        inited? PropertySettingSection(propertyBloc: propertyBloc,): SizedBox(),
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
          if(snapshot.hasError) {
            if(snapshot.error is Error) {
              Error error = snapshot.error;
              print("Error $error \n ${error.stackTrace}");
            }
            print("Error ${snapshot.error}");

          }
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);

          return Material(
            child: snapshot.requireData,
          );
        },
      ),
    );
  }
}

