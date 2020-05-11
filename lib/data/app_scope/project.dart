import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/widget_elements/base/literal_widget.dart';

/// The currently active project
///
/// The project contains all sorts of information related to the project such as:
///
/// The widget board which is accessible through this
///
///
class Project with ChangeNotifier{

  Project() {
    //_widgetBoard.addListener(_onUpdate);
    _widgetBoard = WidgetBoard();
    var literalWidgetElement = LiteralWidgetElement(
        id: Uuid().v1(),
        name: "A widget"
    );
    _widgetBoard.acceptNewChild(_widgetBoard .rootKey, literalWidgetElement);
  }
  WidgetBoard _widgetBoard;
  WidgetBoard get widgetBoard => _widgetBoard;

  StreamController<String> _saveLocation = StreamController();
  Stream<String> get saveLocation => _saveLocation.stream;

  BehaviorSubject<bool> _playModeSubject = BehaviorSubject.seeded(false);
  ValueStream<bool> get playModeStream => _playModeSubject.stream;


  void updatePlayMode(bool playMode) {
    _playModeSubject.add(playMode);
  }

  void dispose() {
    super.dispose();
    _saveLocation.close();
    //_widgetBoard.removeListener(_onUpdate);
    //_widgetBoard.dispose();

  }
  void _onUpdate() {
    //save();
  }

  String _pathToSave;

  void overrideWidgetBoard(WidgetBoard board) {
    //_widgetBoard.removeListener(_onUpdate);
    _widgetBoard = board;
    //_widgetBoard.addListener(_onUpdate);
    notifyListeners();
  }

  /// Sets the path of where to save the file
  void setFilePath(String path) {
    if(path == null) {
      _pathToSave = null;
      _saveLocation.add(null);
      return;
    }
    if(path.endsWith(".dart")) {
      _pathToSave = path;
      _saveLocation.add(path);
    } else {
      print("Path did not end with .dart!");
    }
  }

  Future saveToPath(String path) async {
    setFilePath(path);
    await save();
  }

  Future saveToFolder(String folderPath) async {
    if(folderPath != null) {
      // try 10 different extensions
      for(int i = 0; i < 10; i++) {
        File file = File("$folderPath/widget-maker-${Uuid().v1()}.dart");
        if(!(await file.exists())) {
          var f = await file.create();
          await f.writeAsString(widgetBoard.getLayoutCode());
          return;
        }

      }
    }
  }

  String getCode() {
    return widgetBoard.getLayoutCode();
  }


  Future save() async {
    if(_pathToSave != null) {
      //_isLoadingStream.add(SaveState.saving);
      await File(_pathToSave).writeAsString(widgetBoard.getLayoutCode());
      //_isLoadingStream.add(SaveState.success);
    }
  }



}


enum SaveState {
  saving, success, failure, none
}