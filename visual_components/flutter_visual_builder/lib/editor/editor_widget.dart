import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/components/material_components.dart';
import 'package:flutter_visual_builder/editor/components/visual_components.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette.dart';
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:flutter_visual_builder/server/server.dart';
import 'package:grpc/grpc.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:provider/provider.dart';

class VisualEditor extends StatefulWidget {


  @override
  VisualEditorState createState() {
    return new VisualEditorState();
  }
}

class VisualEditorState extends State<VisualEditor> {


  @override
  void initState() {
    super.initState();
    initServer();
  }

  Future initServer() async {
    final server = new Server([editorServer]);
    await server.serve(port: 50051);
    print('Server listening on port ${server.port}...');

  }

  // TODO, the editor should be able to simulate the same widgets in different
  // settings. Because of that we need to have a way to draw the same widget
  // (with the same state and same global keys etc.) multiple times.
  //
  // This is somewhat a difficult problem. Will probably have to create a custom
  // element which lays out the same widget multiple times and draws it multiple
  // times.
  @override
  Widget build(BuildContext context) {
    return Provider<EditorServer>(
      value: editorServer,
      child: Provider<IDETheme>(
        value: IDETheme.standard(),
        child: Builder(
          builder: (newContext) {
            return Material(
              color: IDETheme.of(newContext).darkBackground,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 9/16,
                  child: AppWidget(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}



class AppWidget extends StatefulWidget {


  @override
  AppWidgetState createState() {
    return new AppWidgetState();
  }
}

class AppWidgetState extends State<AppWidget> {
  final GlobalKey<VisualRootState> rootKey = GlobalKey();

  void onChanged() {
    String source = rootKey.currentState.buildSourceCode();
    editorServer.updateSourceCode.add(SourceCode()..sourceCode = source);
  }

  @override
  Widget build(BuildContext context) {
    return VisualRoot(
      onChanged: onChanged,
      key: rootKey,
      child: VisualScaffold(
        backgroundColor: Colors.white,
        id: "YOOOO",
      ),
    );
  }
}