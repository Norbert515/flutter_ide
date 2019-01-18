import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class EditorServer extends ServerServiceBase {

  @override
  Future<HelloReply> initialize(ServiceCall call, InitializeFileRequest request) {
    Field f = Field()..double = (DoubleField()..value = 4.0);

    f.getField(f.whichIt().index);

    return null;
  }

  @override
  Future<GetFieldsResponse> getFields(ServiceCall call, GetFieldsRequest request) {
    // TODO: implement getFields
    return null;
  }

  @override
  Future<HelloReply> streamUpdate(ServiceCall call, Stream<FieldUpdate> request) {
    // TODO: implement streamUpdate
    return null;
  }


}