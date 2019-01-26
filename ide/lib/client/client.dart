import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:rxdart/rxdart.dart';

class VisualClient {


  VisualClient(this.serverClient);

  final ServerClient serverClient;

  BehaviorSubject<FieldUpdate> _fieldUpdates = BehaviorSubject();
  Sink<FieldUpdate> get fieldUpdates => _fieldUpdates.sink;

  void init() {
    serverClient.streamUpdate(_fieldUpdates);
  }
}