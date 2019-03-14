import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';


enum SearchFor {
  File, Folder
}


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

  static void setSelectedEntity(BuildContext context, String selectedEntity) {
    _FileSystemExplorerState state = context.ancestorStateOfType(TypeMatcher<_FileSystemExplorerState>());
    state.selectedEntity = selectedEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      value: _selectedEntity,
      child: Container()
    );
  }
}




class _Folder extends StatefulWidget {

  const _Folder({Key key, this.directory}) : super(key: key);

  final Directory directory;

  @override
  _FolderState createState() =>  _FolderState();
}

class _FolderState extends State<_Folder> {

  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _FileSystemExplorerState.setSelectedEntity(context, widget.directory.path);
          },
          onDoubleTap: () {
            setState(() {
              open = !open;
            });
          },
          child: Container(
            child: Text(path.basename(widget.directory.path)),
          ),
        ),
        FutureBuilder<List<FileSystemEntity>>(
          future: widget.directory.list().toList(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
            return Column(
              children: snapshot.data.map((it) {
                if(it is Directory) return _Folder(directory: it,);
                if(it is File) return _File(file: it);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

}

class _File extends StatelessWidget {

  const _File({Key key, this.file}) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _FileSystemExplorerState.setSelectedEntity(context, file.path);
      },
      child: Container(
        child: Text(path.basename(file.path)),
      ),
    );
  }
}
