import 'package:flutter_visual_builder/business_logic/server/server.dart';
import 'package:grpc/grpc.dart';

Future<void> main(List<String> args) async {
  final server = new Server([EditorServer()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
