import 'package:grpc/grpc.dart';
import 'package:visual_server/src/server/visual_server.dart';
import 'package:visual_server/src/flutter_manager/flutter_manager.dart';



Future<void> main(List<String> args) async {
  final server = new Server([ServerService()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');


  FlutterManager flutterManager = FlutterManagerImpl();
  // If managed, open flutter manager
}