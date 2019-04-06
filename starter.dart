

import 'dart:io';
//import 'ide/lib_new/data/services/ide_source_code_modifier.dart';

void main() async {


  //var modifier = IdeSourceCodeModifier();
//  await modifier.reset();

  Process process = await Process.start("flutter", ['run', '-dDesktop', '-tlib_new/main.dart'], workingDirectory: "ide", runInShell: true,
      mode: ProcessStartMode.normal);

  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );
  print('Listening on localhost:${server.port}');

  stdout.addStream(process.stdout);

  await for (HttpRequest request in server) {
    process.stdin.writeln("r");
    await process.stdin.flush();
    request.response
      ..writeln("Hot-reloading")
      ..close();
  }
}