import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;


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


  @override
  Widget build(BuildContext context) {
    return Container();
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
    return Container(
      child: Text(path.basename(widget.directory.path)),
    );
  }
}

class _File extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
