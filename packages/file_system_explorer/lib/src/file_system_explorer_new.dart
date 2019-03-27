import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'dart:async';

enum SearchFor { File, Folder }
enum _FlutterFileType { File, Folder }


// TODO implement pattern matching (search for files, just as IntelliJ does)

// TODO implement actual chooser which wraps this widgets and adds
// search patterns and confirm buttons

class _FlutterFileSystem {
  _FlutterFileSystem(Directory root,
      {this.onChanged, this.onMovedToNext, this.onMovedToPrevious, this.onFileSelected}) {
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


  int maxDepth = 0;

  final VoidCallback onChanged;
  final VoidCallback onMovedToNext;
  final VoidCallback onMovedToPrevious;

  final ValueChanged<String> onFileSelected;


  int bufferMaxDepth = 0;

  Iterable<_FlutterFileSystemEntity> convertToLinear() {
    bufferMaxDepth = 0;
    return _convertToLinear(_root);
  }
  Iterable<_FlutterFileSystemEntity> _convertToLinear(
      _FlutterFileSystemEntity root) sync* {

    yield root;
    assert(root is _FlutterFolder);

    _FlutterFolder rootFolder = root;

    if(rootFolder.opened) {
      // The max depth is used because the ListView.builder builds its children
      // lazily, therefore we have no idea what the "deepest" (and thus biggest
      // in x direction) item is.
      // This is intended behavior because the ListView.builder is only supposed
      // to know about the items currently being showcased.

      // But for the horizontal scroll we need some sort of maximum width.
      // We can approximate that width by taking the max depth and multiplying it
      // with the the space added each depth level + max item width
      if(rootFolder.depth > bufferMaxDepth) {
        maxDepth = rootFolder.depth;
        bufferMaxDepth = rootFolder.depth;
      }
      // Can't yield in forEach call
      for (_FlutterFileSystemEntity it in rootFolder.children) {
        if (it.type == _FlutterFileType.Folder) {
          _FlutterFolder folder = it;
          yield* _convertToLinear(folder);
        } else {
          yield it;
        }
      }
    }
  }

  void _invalidate() {
    items = convertToLinear().toList();
    onChanged();
  }

  void toggleCurrent() {
    if(selectedEntity.type == _FlutterFileType.Folder) {
      _FlutterFolder folder = selectedEntity as _FlutterFolder;
      _toggleFolder(folder);
    } else if(selectedEntity.type == _FlutterFileType.File){
      onFileSelected(selectedEntity.path);
    }
  }

  void toggle(int index) {
    _FlutterFileSystemEntity entity = items[index];
    if (entity.type == _FlutterFileType.Folder) {
      _FlutterFolder folder = entity;
      _toggleFolder(folder);
    } else if(entity.type == _FlutterFileType.File){
      onFileSelected(entity.path);
    }
  }

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
/*
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
  }*/


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

abstract class _FlutterFileSystemEntity {
  _FlutterFileSystemEntity(this.depth, this.type);

  final int depth;
  final _FlutterFileType type;

  String get path;
}

class _FlutterFile extends _FlutterFileSystemEntity {
  _FlutterFile({int depth, this.file}) : super(depth, _FlutterFileType.File);

  final File file;

  String get path => file.path;
}

class _FlutterFolder extends _FlutterFileSystemEntity {
  _FlutterFolder({int depth, this.directory})
      : super(depth, _FlutterFileType.Folder);

  final Directory directory;
  bool opened = false;

  bool alreadyLoaded = false;
  List<_FlutterFileSystemEntity> children = [];


  String get path => directory.path;
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
      alreadyLoaded = true;
    })..catchError((it) {
      opened = false;
      this.children = [];
    });
  }

  void close() {
    opened = false;
  }
}

class FileSystemExplorer extends StatefulWidget {
  const FileSystemExplorer({
    Key key,
    this.searchFor,
    this.onPathChanged,
    @required this.onPathSelected,
    this.backgroundColor,
    this.iconColor,
    this.selectedItemColor,
    this.textColor,
    this.rootDirectory,
  }) : assert(onPathSelected != null), super(key: key);

  final SearchFor searchFor;

  final ValueChanged<String> onPathChanged;

  final ValueChanged<String> onPathSelected;

  /// The color of the background of the IDE.
  ///
  /// If not set, [ThemeData.backgroundColor] will be used.
  final Color backgroundColor;

  /// The color of the default icons.
  ///
  /// If not set, [IconThemeData.iconColor] will be used.
  final Color iconColor;

  /// The color of the file name text.
  ///
  /// If not set, the default text color will be used.
  final Color textColor;

  /// The color of the item currently selected.
  ///
  /// If not set, [ThemeData.accentColor] will be used.
  final Color selectedItemColor;


  /// The root directory of the explorer.
  ///
  /// It will not be possible to traverse files above this root directory.
  /// Defaults to C:\\
  final Directory rootDirectory;


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
    root = widget.rootDirectory ?? Directory(path.absolute("C:\\\\"));
    fileSystem = _FlutterFileSystem(
      root,
      onChanged: () {
        if(widget.onPathChanged != null) {
          widget.onPathChanged(fileSystem.selectedEntity.path);
        }
        setState(() {});
      },
      onMovedToNext: moveToNext,
      onMovedToPrevious: moveToPrevious,
      onFileSelected: widget.onPathSelected
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
      double maxHeight = (fileSystem.items.length * _ITEM_HEIGHT) - controller.position.viewportDimension;
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

  void selectAfterTap(int index) {
    fileSystem.select(index);
    if(!focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        backgroundColor: widget.backgroundColor,
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: widget.iconColor
        ),
        accentColor: widget.selectedItemColor,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: widget.textColor),
        child: RawKeyboardListener(
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
            color: Theme.of(context).backgroundColor,
            child: SizedBox(
              height: 600,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Scrollbar(
                      child: SizedBox(
                        width: fileSystem.maxDepth * 20 + 400.0 < constraints.maxWidth?
                          constraints.maxWidth : constraints.maxWidth + fileSystem.maxDepth * 20,
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
                                    selectAfterTap(index);
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
                                    selectAfterTap(index);
                                  },
                                  onFinalSelect: () {
                                    fileSystem.toggle(index);
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Folder extends StatefulWidget{
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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SelectDetector(
      onSelect: widget.onSelect,
      onToggle: widget.onToggle,
      child: Container(
        color: widget.selected ? theme.accentColor : theme.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 20.0 * widget.entity.depth,
            ),
            IconButton(
              onPressed: widget.onToggle,
              icon: Icon(widget.entity.opened
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,),
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
  _File({Key key, this.entity, this.onSelect, this.selected, this.onFinalSelect}) : super(key: key);

  final _FlutterFile entity;
  final VoidCallback onSelect;
  final VoidCallback onFinalSelect;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SelectDetector(
      onSelect: onSelect,
      onToggle: onFinalSelect,
      child: Container(
        color: selected ? theme.accentColor : theme.backgroundColor,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0 * entity.depth,
            ),
            SizedBox(
              width: 24 + 8.0 + 8.0 + 8.0,
            ),
            Icon(Icons.insert_drive_file,),
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


class SelectDetector extends StatefulWidget {

  const SelectDetector({Key key, this.onSelect, this.onToggle, this.child}) : super(key: key);

  final VoidCallback onSelect;
  final VoidCallback onToggle;
  final Widget child;

  @override
  _SelectDetectorState createState() => _SelectDetectorState();
}

class _SelectDetectorState extends State<SelectDetector> {

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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onSelect();
        DateTime now = DateTime.now();
        if (now.millisecondsSinceEpoch - lastTapTime < _DOUBLE_TAP_TIME) {
          widget.onToggle();
        }
        lastTapTime = now.millisecondsSinceEpoch;
        },
      child: widget.child,
    );
  }
}
