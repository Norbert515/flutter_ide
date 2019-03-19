/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

enum SearchFor { File, Folder }
enum _FlutterFileType {File, Folder}


// TODO this recursive widget solution does work, but there are a few
// advantages in using a linear approach

// 1. Can use a ListView.builder which will especially help with longer lists
// 2. Navigating with arrow keys will be significantly easier

class _FlutterFileSystem {

  _FlutterFileSystem(Directory root, this.onChanged) {
    _root = _FlutterFolder(
      depth: 0,
      directory: root,
    );
  }

  _FlutterFileSystemEntity _root;


  int selectedIndex;
  _FlutterFileSystemEntity get selectedEntity => items[selectedIndex];

  List<_FlutterFileSystemEntity> items;

  final VoidCallback onChanged;


  Iterable<_FlutterFileSystemEntity> convertToLinear() => _convertToLinear(_root);
  Iterable<_FlutterFileSystemEntity> _convertToLinear(_FlutterFileSystemEntity root) sync* {
    yield _root;

    assert(_root is _FlutterFolder);

    _FlutterFolder rootFolder = _root;

    // Can't yield in forEach call
    for(_FlutterFileSystemEntity it in rootFolder.children) {
      if(it.type == _FlutterFileType.Folder) {
        _FlutterFolder folder = it;
        if(folder.opened) {
          yield* _convertToLinear(folder);
        }
      } else {
        yield it;
      }
    }
  }

  void open() {
    if(selectedEntity.type == _FlutterFileType.Folder) {
      _FlutterFolder folder = selectedEntity;
      folder.open().then((_) {
        onChanged();
        items = convertToLinear();
      });
    }
  }

  void select(int index) {
    this.selectedIndex = index;
  }

  void selectNext() {
    if(selectedIndex != null) {
      selectedIndex++;
    }
  }

  void selectPrevious() {
    if(selectedIndex != null) {
      selectedIndex--;
    }
  }


}

class _FlutterFileSystemEntity {

  _FlutterFileSystemEntity(this.depth, this.type);

  final int depth;
  final _FlutterFileType type;

}

class _FlutterFile extends _FlutterFileSystemEntity {
  _FlutterFile({int depth, this.file}) : super(depth, _FlutterFileType.File);

  final File file;

}

class _FlutterFolder extends _FlutterFileSystemEntity {
  _FlutterFolder({int depth, this.directory}) : super(depth, _FlutterFileType.File);


  final Directory directory;
  bool opened = false;

  bool alreadyLoaded = false;
  List<_FlutterFileSystemEntity> children;


  Future open() {
    if(alreadyLoaded) return Future.value();
    return directory.list().toList().then((it) {
      this.children = it.map((it) {
        if(it is File) {
          return _FlutterFile(
            depth: depth + 1,
            file: it,
          );
        } else if(it is Directory) {
          return _FlutterFolder(
            depth: depth + 1,
            directory: it,
          );
        }
      });
    });
  }

}





class FileSystemExplorer extends StatefulWidget {
  const FileSystemExplorer({Key key, this.searchFor}) : super(key: key);

  final SearchFor searchFor;

  @override
  _FileSystemExplorerState createState() => _FileSystemExplorerState();
}

class _FileSystemExplorerState extends State<FileSystemExplorer> {


  FocusNode focusNode;

  PublishSubject<void> _onPressedSubject = PublishSubject();

  String _selectedEntity;
  set selectedEntity(String it) {
    setState(() {
      _selectedEntity = it;
    });
  }

  Directory root;

  @override
  void initState() {
    super.initState();
    root = Directory(path.absolute("C:\\\\"));
    focusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(focusNode);
  }


  @override
  void dispose() {
    focusNode.dispose();
    _onPressedSubject.close();
    super.dispose();
  }

  static void setSelectedEntity(BuildContext context, String selectedEntity) {
    _FileSystemExplorerState state =
        context.ancestorStateOfType(TypeMatcher<_FileSystemExplorerState>());
    state.selectedEntity = selectedEntity;
  }

  static String getSelectedEntity(BuildContext context) {
    _FileSystemExplorerState state =
        context.ancestorStateOfType(TypeMatcher<_FileSystemExplorerState>());
    return state._selectedEntity;
  }

  static Observable<void> getEnterStream(BuildContext context) {
    _FileSystemExplorerState state = context.ancestorStateOfType(TypeMatcher<_FileSystemExplorerState>());
    return state._onPressedSubject.stream;
  }


  void moveUp() {

  }

  void moveDown() {

  }

  void select() {
    _onPressedSubject.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (rawKey) {
        // TODO dart embedder doesn't send all raw event right now, this is going to
        // be fixed at some point.
        if(rawKey is RawKeyUpEvent) {

        } else if(rawKey is RawKeyDownEvent) {
          RawKeyDownEvent event = rawKey;
          var it = event.data as RawKeyEventDataFuchsia;
          if(it.hidUsage == 81) moveDown();
          if(it.hidUsage == 82) moveUp();
          if(it.hidUsage == 40) select();
        }

      },
      child: Provider<String>(
          value: _selectedEntity,
          child: Material(
            child: SizedBox(
              height: 600,
              child: SingleChildScrollView(
                child: Container(
                  width: 200,
                  color: Colors.green,
                  child: _Folder(
                    directory: root,
                    depth: 1,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class _Folder extends StatefulWidget {
  _Folder({Key key, this.directory, this.depth})
      : super(key: ValueKey(directory.path));

  final Directory directory;
  final int depth;

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<_Folder> {
  bool open = false;

  List<FileSystemEntity> cachedEntities;

  /// Custom double tap behavior
  ///
  /// Because the [GestureDetector] shouldn't wait until a possible
  /// second tap has occurred. Instead it should select the item and open the folder
  /// on the second tap.
  int lastTapTime = 0;

  /// In milliseconds
  static const int _DOUBLE_TAP_TIME = 500;


  Future _openDirectoryFuture;

  @override
  void initState() {
    super.initState();
    _openDirectoryFuture = widget.directory.list().toList();
    _FileSystemExplorerState.getEnterStream(context).listen((_) {
      if(_FileSystemExplorerState.getSelectedEntity(context) == widget.directory.path) {
        setState(() {
          open = !open;
        });
      }
    });
  }

  void openDirectory() {

  }

  @override
  Widget build(BuildContext context) {
    bool selected = _FileSystemExplorerState.getSelectedEntity(context) ==
        widget.directory.path;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          color: selected ? Colors.blue : Colors.green,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _FileSystemExplorerState.setSelectedEntity(
                  context, widget.directory.path);
              DateTime now = DateTime.now();
              if(now.millisecondsSinceEpoch - lastTapTime < _DOUBLE_TAP_TIME) {
                setState(() {
                  open = !open;
                });
              }
              lastTapTime = now.millisecondsSinceEpoch;

            },
            /*onDoubleTap: () {
              setState(() {
                open = !open;
              });
            },*/
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 20.0 * widget.depth,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      open = !open;
                    });
                  },
                  icon: Icon(open
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                ),
                Icon(Icons.folder),
                SizedBox(
                  width: 8,
                ),
                Text(path.basename(widget.directory.path)),
              ],
            ),
          ),
        ),
        open
            ? FutureBuilder<List<FileSystemEntity>>(
                future: _openDirectoryFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data.map((it) {
                      if (it is Directory)
                        return _Folder(
                          directory: it,
                          depth: widget.depth + 1,
                        );
                      if (it is File)
                        return _File(
                          file: it,
                          depth: widget.depth + 1,
                        );
                    }).toList(),
                  );
                },
              )
            : SizedBox(),
      ],
    );
  }
}

class _File extends StatelessWidget {
  _File({Key key, this.file, this.depth}) : super(key: ValueKey(file.path));

  final File file;
  final int depth;

  @override
  Widget build(BuildContext context) {
    bool selected =
        _FileSystemExplorerState.getSelectedEntity(context) == file.path;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _FileSystemExplorerState.setSelectedEntity(context, file.path);
      },
      child: Container(
        color: selected ? Colors.blue : Colors.green,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0 * depth,
            ),
            SizedBox(
              width: 24 + 8.0 + 8.0 + 8.0,
            ),
            Icon(Icons.insert_drive_file),
            Container(
              padding:
                  EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16), //
              child: Text(path.basename(file.path)),
            ),
          ],
        ),
      ),
    );
  }
}*/
