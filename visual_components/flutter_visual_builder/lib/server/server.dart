import 'package:flutter_visual_builder/generated/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class ServerService extends ServerServiceBase {

  @override
  Future<HelloReply> initialize(ServiceCall call, InitializeFileRequest request) {
    Field f = Field()..double = (DoubleField()..value = 4.0);

    f.getField(f.whichIt().index);

    return null;
  }


}