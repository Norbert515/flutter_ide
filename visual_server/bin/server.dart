import 'dart:async';
import 'package:grpc/grpc.dart';

import 'package:visual_server/src/generate/server.pb.dart';
import 'package:visual_server/src/generate/server.pbgrpc.dart';

class ServerService extends ServerServiceBase {

  @override
  Future<HelloReply> initialize(ServiceCall call, InitializeFileRequest request) {
    return null;
  }


}

Future<void> main(List<String> args) async {
  final server = new Server([ServerService()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
