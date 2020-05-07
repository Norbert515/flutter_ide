import 'package:file_system_explorer/file_system_explorer.dart';
import 'package:widget_maker_2_0/data/app_scope/app_scope.dart';
import 'package:widget_maker_2_0/data/app_scope/code_sync/intellij_project.dart';
import 'package:widget_maker_2_0/data/app_scope/project.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:widget_maker_2_0/ui/theme.dart';
import 'package:widget_maker_2_0/ui/widgets/dialogs/new_project_dialog.dart';


class TopNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      color: MyTheme.of(context).background4dp,
      child: Row(
        children: <Widget>[
          _NavigationItem(
            text: "File",
            onTap: () {}
          ),
          _NavigationItem(
            text: "Edit",
            onTap: () {},
          ),
          _NavigationItem(
            text: "View",
            onTap: () {}
          ),
          _NavigationItem(
              text: "Debug Dump Focus Tree",
              onTap: () {
                debugDumpFocusTree();
              }
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {

  const _NavigationItem({Key key, this.text, this.onTap}) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
      onTap: onTap,
    );
  }
}



class NavigationBar extends StatelessWidget {


  final bool showVisual;
  final ValueChanged<bool> onUpdate;

  const NavigationBar({Key key, this.showVisual, this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.photo_size_select_actual, size: 16,),
                onPressed: (){
                  showNewProjectDialog(context);

                },
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.transform, size: 16),
                        onPressed: () => onUpdate(true),
                        tooltip: "Designer",
                      ),
                    ),
                    Text("Designer", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w200),),
                  ],
                ),
              ),
              VerticalDivider(),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.code, size: 16),
                        onPressed: () => onUpdate(false),
                        tooltip: "Code",
                      ),
                    ),
                    Text("Code", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w200),),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          /*Expanded(
            child: StreamBuilder<String>(
              stream: AppScope.of(context).saveLocation,
              builder: (context, snapshot) {
                var data = snapshot.data;
                return Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () async {
                          if(data == null) {
                            String path = await showPicker(
                                context, topInfo: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Select a file to write the code to"
                                  "\n IMPORTANT: THE FILE WILL BE OVERWRITTEN",
                                textAlign: TextAlign.center,),
                            ));
                            AppScope.of(context).setFilePath(path);
                            AppScope.of(context).save();
                          } else {
                            AppScope.of(context).save();
                          }
                          //IntellijPusher.of(context).path = path;
                        },
                      ),
                      Text(data == null? "Choose Location": "Save"),
                    ],
                  ),
                );
              }
            ),
          ),*/
        ],
      ),
    );
  }
}
