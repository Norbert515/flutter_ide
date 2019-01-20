import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_visual_builder/editor/editor_widget.dart';
import 'package:ide/client/client.dart';
import 'package:ide/ui/widget_editors/common_editors.dart';

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

  @override
  void initState(){
    super.initState();
    init();
  }


  void init() async {
    await Future.delayed(Duration(seconds: 2));
    serverClient = VisualClient(ServerClient(ClientChannel("localhost", port: 50051, options: ChannelOptions(credentials: ChannelCredentials.insecure()))));
    serverClient.init();
    setState(() {
      inited = true;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: VisualEditor()),
        inited? PropertySettingSection(): SizedBox(),
      ],
    );
  }

}

class PropertySettingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 400,
      height: double.infinity,
      child: StreamBuilder<SelectedWidgetWithProperties>(
        stream: serverClient.serverClient.streamSelected(SelectStream()),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);

          return Material(
            child: ContainerEditor(
             key: ValueKey(snapshot.requireData.id),
             id: snapshot.requireData.id,
            ),
          );
        },
      ),
    );
  }
}

