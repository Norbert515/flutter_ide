import 'dart:convert';
import 'dart:io';

class Server {

  Process process;


  WebSocket widgetMakerSocket;
  WebSocket ideSocket;

  void init() async {
    int textPort = 9243;

    await HttpServer.bind(InternetAddress.loopbackIPv4, textPort).then((server) {
      print("Text server is running on "
          "'http://${server.address.address}:$textPort/'");

      server.transform(WebSocketTransformer())
            .listen(handleText);
    });

    process = await Process.start("flutter", ['run', '-dWindows', '-tlib/main.dart',], runInShell: true,
        mode: ProcessStartMode.normal);
    process.stdout.pipe(stdout);
    process.stderr.pipe(stderr);
  }


  void handleText(WebSocket webSocket) {

    String type;

    // Listen for incoming data. We expect the data to be a JSON-encoded String.
    webSocket
        .listen((text) async {

          print("Got from $type this: $text");
      if(text == "ide") {
        ideSocket = webSocket;
        type = "ide";
        return;
      } else if(text == "widget_maker") {
        widgetMakerSocket = webSocket;
        type = "widget_maker";
        return;
      }

    if(type == "ide") {
      var file = File("lib/temp_widget.dart");
      file.writeAsStringSync(text, flush: true);
      process.stdin.writeln("r");
      await process.stdin.flush();
    } else if(type == "widget_maker") {
      ideSocket.add(text);
    }

    }, onError: (error) {
      print('Bad WebSocket request');
    });
  }
}