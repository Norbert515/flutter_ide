import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Norbert/workspace/flutter_ide/lib/modules/workspace/widget_board.dart';
//import "../../../pkg/widget_converter/lib/converter.dart";

class SyncServer {

  WebSocket _webSocket;
  WebSocket _otherWebSocket;

  final ValueChanged<WidgetBoard> set;

  SyncServer(this.set);

  void connect() async {
    try {
      _webSocket = await WebSocket.connect("ws://127.0.0.1:9244/");
      _otherWebSocket = await WebSocket.connect("ws://127.0.0.1:9243");
      _otherWebSocket?.add("widget_maker");
    } catch(e) {
      print("Could not connect to socket");
    }

    _webSocket?.listen(listen);
  }


  void sendCode(String code) {
    //print("Sending $code");
    _otherWebSocket?.add(code);
  }

  void listen(dynamic msg) {
/*
    Map map = json.decode(msg);

    Map<String, WidgetElement> all = Map();

    var elem = convert(map, all);

    WidgetBoard board = WidgetBoard();

    void register(WidgetElement parent, WidgetElement elem) {
      board.preRegisterChild(elem);
      board.acceptChild(parent.id, elem.id, parent.getDataForChild(elem.id));
      for(String key in elem.children.where((it) => it.hasChild).map((it) => it.childId).toList()) {
        assert(all.containsKey(key), "${elem.runtimeType} did not contain key:$key");
        register(elem, all[key]);
      }
    }

    register(board.rootWidgetElement, elem);

    set(board);

    print(elem);
    print(all);
*/
  }

}
