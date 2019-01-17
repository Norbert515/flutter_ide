import 'package:flutter_visual_builder/generate/server.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class ServerService extends ServerServiceBase {

  @override
  Future<HelloReply> initialize(ServiceCall call, InitializeFileRequest request) {
    return null;
  }


}