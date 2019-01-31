
import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:ide/client/client.dart';
import 'package:ide/logic/property_bloc.dart';
import 'package:provider/provider.dart';

class PropertyEditorProvider extends StatefulWidget {


  const PropertyEditorProvider({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _PropertyEditorProviderState createState() => _PropertyEditorProviderState();
}

class _PropertyEditorProviderState extends State<PropertyEditorProvider> {


  VisualClient serverClient;
  PropertyBloc propertyBloc;

  @override
  void initState() {
    super.initState();
    serverClient = VisualClient(ServerClient(ClientChannel("localhost", port: 50051, options: ChannelOptions(credentials: ChannelCredentials.insecure()))));
    serverClient.init();
    propertyBloc = PropertyBloc(serverClient);

  }
  @override
  Widget build(BuildContext context) {
    return Provider<VisualClient>(
      value: serverClient,
      child: Provider<PropertyBloc>(
        value: propertyBloc,
        child: widget.child,
      ),
    );
  }
}
