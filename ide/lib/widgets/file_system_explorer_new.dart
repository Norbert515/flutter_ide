import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

enum SearchFor { File, Folder }
enum _FlutterFileType { File, Folder }

// TODO this recursive widget solution does work, but there are a few
// advantages in using a linear approach

// 1. Can use a ListView.builder which will especially help with longer lists
// 2. Navigating with arrow keys will be significantly easier

class _FlutterFileSystem {
  _FlutterFileSystem(Directory root,
      {this.onChanged, this.onMovedToNext, this.onMovedToPrevious}) {
    _root = _FlutterFolder(
      depth: 0,
      directory: root,
    );

    items = [_root];
  }

  _FlutterFileSystemEntity _root;

  int selectedIndex;
  _FlutterFileSystemEntity get selectedEntity => items[selectedIndex];

  List<_FlutterFileSystemEntity> items;

  final VoidCallback onChanged;
  final VoidCallback onMovedToNext;
  final VoidCallback onMovedToPrevious;

  Iterable<_FlutterFileSystemEntity> convertToLinear() =>
      _convertToLinear(_root);
  Iterable<_FlutterFileSystemEntity> _convertToLinear(
      _FlutterFileSystemEntity root) sync* {
    yield root;

    assert(root is _FlutterFolder);

    _FlutterFolder rootFolder = root;

    // Can't yield in forEach call
    for (_FlutterFileSystemEntity it in rootFolder.children) {
      if (it.type == _FlutterFileType.Folder) {
        _FlutterFolder folder = it;
        if (folder.opened) {
          yield* _convertToLinear(folder);
        } else {
          yield folder;
        }
      } else {
        yield it;
      }
    }
  }

  void _invalidate() {
    items = convertToLinear().toList();
    onChanged();
  }

  void toggleCurrent() => _toggleFolder(_maybeGetCurrentFolder());

  void toggle(int index) => _toggleFolder(_maybeGetFolder(index));

  void _toggleFolder(_FlutterFolder folder) {
    if(folder != null) {
      if(folder.opened) {
        folder.close();
        _invalidate();
      } else {
        folder.open().then((_) => _invalidate());
      }
    }
  }

  void closeCurrent() {
    _maybeGetCurrentFolder()?.close();
    _invalidate();
  }

  void close(int index) {
    _maybeGetFolder(index)?.close();
    _invalidate();
  }

  void openCurrent() {
    _maybeGetCurrentFolder()?.open()?.then((_) => _invalidate());
  }

  void open(int index) {
    _maybeGetFolder(index)?.open()?.then((_) => _invalidate());
  }

  _FlutterFolder _maybeGetCurrentFolder() {
    if(selectedEntity.type == _FlutterFileType.Folder) {
      return selectedEntity as _FlutterFolder;
    } else {
      return null;
    }
  }
  _FlutterFolder _maybeGetFolder(int index) {
    _FlutterFileSystemEntity entity = items[index];
    if (entity.type == _FlutterFileType.Folder) {
      _FlutterFolder folder = entity;
      return folder;
    } else {
      return null;
    }
  }


  void select(int index) {
    this.selectedIndex = index;
    onChanged();
  }

  void selectNext() {
    if (selectedIndex != null && selectedIndex < items.length - 1) {
      selectedIndex++;
      onChanged();
      onMovedToNext();
    }
  }

  void selectPrevious() {
    if (selectedIndex != null && selectedIndex > 0) {
      selectedIndex--;
      onChanged();
      onMovedToPrevious();
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
  _FlutterFolder({int depth, this.directory})
      : super(depth, _FlutterFileType.Folder);

  final Directory directory;
  bool opened = false;

  bool alreadyLoaded = false;
  List<_FlutterFileSystemEntity> children;

  Future open() {
    opened = true;
    if (alreadyLoaded) return Future.value();
    return directory.list().toList().then((it) {
      this.children = it.map((it) {
        if (it is File) {
          return _FlutterFile(
            depth: depth + 1,
            file: it,
          );
        } else if (it is Directory) {
          return _FlutterFolder(
            depth: depth + 1,
            directory: it,
          );
        }
      }).toList();
    });
  }

  void close() {
    opened = false;
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

  _FlutterFileSystem fileSystem;

  Directory root;

  ScrollController controller;

  static const int _NUM_ITEMS_BEFORE_SCROLL = 3;
  static const double _ITEM_HEIGHT = 40;

  @override
  void initState() {
    super.initState();
    root = Directory(path.absolute("C:\\\\"));
    fileSystem = _FlutterFileSystem(
      root,
      onChanged: () {
        setState(() {});
      },
      onMovedToNext: moveToNext,
      onMovedToPrevious: moveToPrevious,
    );
    focusNode = FocusNode();
    controller = ScrollController();
  }

  void moveToNext() {
    double currentOffset = fileSystem.selectedIndex * _ITEM_HEIGHT;
    double remainingSpace = controller.position.extentBefore +
        controller.position.extentInside -
        currentOffset;
    if (remainingSpace < _ITEM_HEIGHT * _NUM_ITEMS_BEFORE_SCROLL) {
      double jumpTo = controller.offset + _ITEM_HEIGHT;
      double maxHeight = (fileSystem.items.length * _ITEM_HEIGHT) - controller.position.extentBefore;
      if(jumpTo <= maxHeight) {
        controller.jumpTo(jumpTo);
      } else {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    }
  }

  void moveToPrevious() {
    double currentOffset = fileSystem.selectedIndex * _ITEM_HEIGHT;
    double remainingSpace = currentOffset - controller.position.extentBefore;
    if (remainingSpace < _ITEM_HEIGHT * _NUM_ITEMS_BEFORE_SCROLL) {
      double jumpTo = controller.offset - _ITEM_HEIGHT;
      if(jumpTo >= 0) {
        controller.jumpTo(jumpTo);
      } else {
        controller.jumpTo(0);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void moveUp() {
    fileSystem.selectPrevious();
  }

  void moveDown() {
    fileSystem.selectNext();
  }

  void select() {
    fileSystem.toggleCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (rawKey) {
        // TODO dart embedder doesn't send all raw event right now, this is going to
        // be fixed at some point.
        if (rawKey is RawKeyUpEvent) {
        } else if (rawKey is RawKeyDownEvent) {
          RawKeyDownEvent event = rawKey;
          var it = event.data as RawKeyEventDataFuchsia;
          if (it.hidUsage == 81) moveDown();
          if (it.hidUsage == 82) moveUp();
          if (it.hidUsage == 40) select();
        }
      },
      child: Material(
        child: SizedBox(
          height: 600,
          child: Scrollbar(
            child: ListView.builder(
              itemExtent: _ITEM_HEIGHT,
              controller: controller,
              itemCount: fileSystem.items.length,
              itemBuilder: (context, index) {
                _FlutterFileSystemEntity entity = fileSystem.items[index];

                bool selected = fileSystem.selectedIndex == index;

                if (entity.type == _FlutterFileType.Folder) {
                  return SizedBox(
                    height: _ITEM_HEIGHT,
                    child: _Folder(
                      key: ObjectKey((entity as _FlutterFolder).directory.path),
                      entity: entity as _FlutterFolder,
                      selected: selected,
                      onSelect: () {
                        fileSystem.select(index);
                      },
                      onToggle: () {
                        fileSystem.toggle(index);
                      },
                    ),
                  );
                } else if (entity.type == _FlutterFileType.File) {
                  return SizedBox(
                    height: _ITEM_HEIGHT,
                    child: _File(
                      key: ObjectKey((entity as _FlutterFile).file.path),
                      entity: entity as _FlutterFile,
                      selected: selected,
                      onSelect: () {
                        fileSystem.select(index);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Folder extends StatefulWidget {
  _Folder({Key key, this.entity, this.onToggle, this.onSelect, this.selected})
      : super(key: key);

  final _FlutterFolder entity;

  final VoidCallback onToggle;
  final VoidCallback onSelect;

  final bool selected;

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<_Folder> {
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
    return Container(
      color: widget.selected ? Colors.blue : Colors.green,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.onSelect();
          DateTime now = DateTime.now();
          if (now.millisecondsSinceEpoch - lastTapTime < _DOUBLE_TAP_TIME) {
            widget.onToggle();
          }
          lastTapTime = now.millisecondsSinceEpoch;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: 20.0 * widget.entity.depth,
            ),
            IconButton(
              onPressed: widget.onToggle,
              icon: Icon(widget.entity.opened
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
            ),
            Icon(Icons.folder),
            SizedBox(
              width: 8,
            ),
            Text(path.basename(widget.entity.directory.path)),
          ],
        ),
      ),
    );
  }
}

class _File extends StatelessWidget {
  _File({Key key, this.entity, this.onSelect, this.selected}) : super(key: key);

  final _FlutterFile entity;
  final VoidCallback onSelect;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onSelect,
      child: Container(
        color: selected ? Colors.blue : Colors.green,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0 * entity.depth,
            ),
            SizedBox(
              width: 24 + 8.0 + 8.0 + 8.0,
            ),
            Icon(Icons.insert_drive_file),
            Container(
              padding:
                  EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16), //
              child: Text(path.basename(entity.file.path)),
            ),
          ],
        ),
      ),
    );
  }
}
