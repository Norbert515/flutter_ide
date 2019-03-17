import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

enum SearchFor { File, Folder }

class FileSystemExplorer extends StatefulWidget {
  const FileSystemExplorer({Key key, this.searchFor}) : super(key: key);

  final SearchFor searchFor;

  @override
  _FileSystemExplorerState createState() => _FileSystemExplorerState();
}

class _FileSystemExplorerState extends State<FileSystemExplorer> {
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
    root = Directory(path.absolute(""));
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

  @override
  Widget build(BuildContext context) {
    return Provider<String>(
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
        ));
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
                future: widget.directory.list().toList(),
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
}
