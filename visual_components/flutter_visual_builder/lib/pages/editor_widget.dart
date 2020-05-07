import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/business_logic/server/generated/server.pb.dart';
import 'package:flutter_visual_builder/business_logic/server/server.dart';
import 'package:flutter_visual_builder/widgets/components/general/text_component.dart';
import 'package:flutter_visual_builder/widgets/components/material_components.dart';
import 'package:flutter_visual_builder/widgets/components/visual_components.dart';
import 'package:flutter_visual_builder/widgets/tree.dart';
import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';
import 'package:ide/themeing/ide_theme.dart';

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

  ValueNotifier<bool> changed = ValueNotifier(false);

  void onChanged() {
    String source = rootKey.currentState.buildSourceCode();
    editorServer.updateSourceCode.add(SourceCode()..sourceCode = source);
    changed.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    VisualStatefulWidget visualStatefulWidget = VisualScaffold(
      backgroundColor: Colors.white,
      id: "root",
    );
    return Row(
      children: <Widget>[
        /*SizedBox(
          width: 200,
          child: TreeView(
            changed: changed,
            visualStatefulWidget: visualStatefulWidget,
          ),
        ),*/
        Expanded(
          child: VisualRoot(
              onChanged: onChanged,
              key: rootKey,
              child: visualStatefulWidget,
            ),
        ),
      ],
    );
  }
}


/// TODO statefulness does not currently work because setState rebuild all widgets
///
/// There are also a few semantical problems, what happens when the widget
/// receiving local input moves?  How is that dealt with.
///
/// Some thought - probably best to indentify it with it's id and then somehow
/// manually call through.
class StatefulEditorStuff extends StatefulWidget {
  @override
  _StatefulEditorStuffState createState() => _StatefulEditorStuffState();
}

class _StatefulEditorStuffState extends State<StatefulEditorStuff> {

  final GlobalKey<VisualRootState> rootKey = GlobalKey();

  void onChanged() {
    String source = rootKey.currentState.buildSourceCode();
    editorServer.updateSourceCode.add(SourceCode()..sourceCode = source);
  }


  int count = 0;

  @override
  Widget build(BuildContext context) {
    return VisualRoot(
      onChanged: onChanged,
      key: rootKey,
      child: VisualScaffold(
        body: TextComponent(text: count.toString()),
        id: "root",
        floatingActionButton: VisualFloatingActionButton(
          onPressed: () {
            print("Yes");
            setState(() {
              count++;
              print("Ye");
            });
            },
          id: "FAB",
        ),
      )
    );
  }
}

