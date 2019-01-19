import 'package:flutter_visual_builder/editor/key_resolver.dart';
import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:rxdart/rxdart.dart';

class EditorServer extends ServerServiceBase {


  PublishSubject<SelectedWidgetWithProperties> updateSubject = PublishSubject();

  @override
  Future<HelloReply> initialize(ServiceCall call, InitializeFileRequest request) {
    print("Got init!");
    return null;
  }

  @override
  Future<GetFieldsResponse> getFields(ServiceCall call, GetFieldsRequest request) {
    return null;
  }

  @override
  Future<HelloReply> streamUpdate(ServiceCall call, Stream<FieldUpdate> request) {
    // TODO move this logic out of here

    request.listen((it) {
      var widgetId = it.id;
      var propertyName = it.propertyName;
      var state = keyResolver.map[widgetId];
      state.currentState.setValue(propertyName, null);
    });

    return Future(() => HelloReply());
  }

  @override
  Stream<SelectedWidgetWithProperties> streamSelected(ServiceCall call, SelectStream request) {
    return updateSubject.stream;
  }


}