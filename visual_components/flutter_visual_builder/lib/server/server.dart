import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:rxdart/rxdart.dart';

class EditorServer extends ServerServiceBase {


  PublishSubject<SelectedWidgetWithProperties> updateSubject = PublishSubject();

  @override
  Future<HelloReply> initialize(ServiceCall call, InitializeFileRequest request) {
    Field f = Field()..double = (DoubleField()..value = 4.0);

    f.getField(f.whichIt().index);

    return null;
  }

  @override
  Future<GetFieldsResponse> getFields(ServiceCall call, GetFieldsRequest request) {
    return null;
  }

  @override
  Future<HelloReply> streamUpdate(ServiceCall call, Stream<FieldUpdate> request) {
    return null;
  }

  @override
  Stream<SelectedWidgetWithProperties> streamSelected(ServiceCall call, SelectStream request) {
    return updateSubject.stream;
  }


}