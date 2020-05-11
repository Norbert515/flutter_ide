import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/interactors/board_interactor.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/canvas.dart';
import 'package:widget_maker_2_0/ui/pages/workspace_page/dart_code.dart';
import 'package:widget_maker_2_0/ui/widgets/dialogs/new_project_dialog.dart';
import 'package:widget_maker_2_0/ui/widgets/dialogs/quick_widget_access_dialog.dart';

import 'bars/context_tool_bar/context_tool_bar.dart';
import 'bars/left_bar/left_bar.dart';
import 'bars/navigation_bar.dart';
import 'bars/palette/palette_dialog.dart';
import 'bars/right_bar/right_bar.dart';

class QuickAccessWidgetsIntent extends Intent {}
class DeleteIntent extends Intent {}

class MShortCutManager extends ShortcutManager {
    /// Handles a key pressed `event` in the given `context`.
  ///
  /// The optional `keysPressed` argument provides an override to keys that the
  /// [RawKeyboard] reports. If not specified, uses [RawKeyboard.keysPressed]
  /// instead.
  @protected
  bool handleKeypress(
    BuildContext context,
    RawKeyEvent event, {
    LogicalKeySet keysPressed,
  }) {
    if (event is! RawKeyDownEvent) {
      return false;
    }
    assert(context != null);
    final LogicalKeySet keySet = keysPressed ?? LogicalKeySet.fromSet(RawKeyboard.instance.keysPressed);
    Intent matchedIntent = shortcuts[keySet];
    if (matchedIntent == null) {
      // If there's not a more specific match, We also look for any keys that
      // have synonyms in the map.  This is for things like left and right shift
      // keys mapping to just the "shift" pseudo-key.
      final Set<LogicalKeyboardKey> pseudoKeys = <LogicalKeyboardKey>{};
      for (LogicalKeyboardKey setKey in keySet.keys) {
        final Set<LogicalKeyboardKey> synonyms = setKey.synonyms;
        if (synonyms.isNotEmpty) {
          // There currently aren't any synonyms that match more than one key.
          pseudoKeys.add(synonyms.first);
        } else {
          pseudoKeys.add(setKey);
        }
      }
      for(LogicalKeyboardKey it in pseudoKeys) {
        //print(it.debugName);
        print(it.keyId);
      }
      matchedIntent = shortcuts[LogicalKeySet.fromSet(pseudoKeys)];
    }
    if (matchedIntent != null) {
      final BuildContext primaryContext = WidgetsBinding.instance.focusManager.primaryFocus?.context;
      if (primaryContext == null) {
        return false;
      }
      return Actions.invoke(primaryContext, matchedIntent, nullOk: true);
    }
    return false;
  }

}


class WorkspacePage extends StatefulWidget {
  @override
  _WorkspacePageState createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {

  bool showVisual = true;
  bool showingQuickAction = false;

  final FocusScopeNode workspaceNode = FocusScopeNode(debugLabel: "Worksapce Node");

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await showNewProjectDialog(context,);
      //FocusScope.of(context).requestFocus(workspaceNode);
    });
  }


  @override
  void dispose() {
    super.dispose();
    workspaceNode.dispose();
  }
  void onSpace() async {
    if(showingQuickAction) return;
    showingQuickAction = true;
    var element = await quickChooseWidgetElement(context);
    showingQuickAction = false;
    BoardInteractor().insertPaletteItem(context, element);
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        QuickAccessWidgetsIntent: CallbackAction(onInvoke: (intent) {
          onSpace();
          return true;
        }),
        DeleteIntent: CallbackAction(onInvoke: (intent) {
          BoardInteractor().delete(context);
          return true;
        }),
      },
      child: Shortcuts(
        manager: MShortCutManager(),
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.space): QuickAccessWidgetsIntent(),
          LogicalKeySet(LogicalKeyboardKey.delete): DeleteIntent(),
        },
        child: Focus(
          focusNode: workspaceNode,
          autofocus: true,
          child: Material(
            child: Column(
              children: <Widget>[
                //TopNavigationBar(),
                NavigationBar(
                  showVisual: showVisual,
                  onUpdate: (it) {
                    setState(() {
                      showVisual = it;
                    });
                  },
                ),
                Expanded(
                  child: SizedBox(
                    child: showVisual? VisualWorkspace(
                      onNewWidget: () async {
                        // TODO no idea why this doesn't work in [LeftBar] class
                        // somehow the pointer is absorbed with that context
                        // pulled it up here for just now so it works for first alpha
                        var element = await showPaletteDialog(context);
                        BoardInteractor().insertPaletteItem(context, element);
                      },
                      onTemplate: () {

                      },
                    ) : CodeWorkspace(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class VisualWorkspace extends StatelessWidget {

  final VoidCallback onNewWidget;
  final VoidCallback onTemplate;

  const VisualWorkspace({Key key, this.onNewWidget, this.onTemplate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth < 720) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
          /*  drawer: Drawer(
              child: Palette(),
            ),*/
            body: Row(
              children: <Widget>[
                DrawerController(
                  child: Drawer(child: SizedBox(),),
                  alignment: DrawerAlignment.start,
                ),
                Expanded(child: DeselectWidget(child: CanvasSpace())),
              ],
            ),
            endDrawer: Drawer(
              child: RightBar(),
            ),
          );

        } else {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Row(
                children: [
                  //Palette(),
                  LeftBar(
                    onNewWidget: onNewWidget,
                    onTemplate: onTemplate,
                  ),
                  Expanded(child: Column(
                    children: <Widget>[
                      ContextToolBar(),
                      Expanded(child: DeselectWidget(child: CanvasSpace())),
                    ],
                  )),
                  /*SizedBox(
                    child: WidgetTree(),
                    width: 300,
                  ),*/
                  RightBar(),
                ]
            ),
          );
        }
      }
    );

  }
}

class CodeWorkspace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff2b2b2b),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: DartCode(
                    code: AppScope.of(context).widgetBoard.getLayoutCode(),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 400,
                  height: 56,
                  child: Center(
                    child: RaisedButton(
                      onPressed: () async {
                        if(kIsWeb) {
                          Clipboard.setData(ClipboardData(
                            text: AppScope.of(context).getCode(),
                          ));
                          return;
                        }
                        String path = await showPicker(
                            context,
                            searchFor: FlutterFileType.Folder,
                            topInfo: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Select a folder to write the code to",
                            textAlign: TextAlign.center,),
                        ));
                        AppScope.of(context).saveToFolder(path);
                      },
                      child: Text(kIsWeb? "Copy to clipboard": "Export"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
