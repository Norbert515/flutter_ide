import 'package:flutter_visual_builder/editor/config.dart';
import 'package:flutter_visual_builder/editor/key_resolver.dart';
import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_visual_builder/editor/properties/converter.dart';

final EditorServer editorServer = EditorServer();


class EditorServer extends ServerServiceBase {


  PublishSubject<SelectedWidgetWithProperties> updateSubject = PublishSubject();
  
  PublishSubject<SourceCode> updateSourceCode = PublishSubject();

  PublishSubject<RemovedWidget> removedWidgetsSubject = PublishSubject();

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
  Future<HelloReply> streamUpdate(ServiceCall call, Stream<FieldUpdate> request) async {

    // TODO move this logic out of here
    await for (var it in request) {
      if(debug) {
        print("Resceived ${it.toString()}");
      }
      var widgetId = it.id;
      var propertyName = it.propertyName;
      var state = keyResolver.map[widgetId];
      state.currentState.setValue(propertyName, convertToProperty(it.property));
    }
    return HelloReply();
  }

  @override
  Stream<SelectedWidgetWithProperties> streamSelected(ServiceCall call, SelectStream request) {
    return updateSubject.stream;
  }

  @override
  Stream<SourceCode> streamSourceCode(ServiceCall call, InitSourceCodeStream request) {
    return updateSourceCode;
  }

  @override
  Stream<RemovedWidget> streamRemovedWidgets(ServiceCall call, Empty request) {
    return removedWidgetsSubject.stream;
  }


}