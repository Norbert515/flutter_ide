import 'package:flutter/material.dart';
import 'package:file_system_explorer/src/file_system_explorer_new.dart';

Future<String> showPicker(BuildContext context) {
  return showDialog(context: context, builder: (context) {
    return Dialog(
      child: FilePickerDialog()
    );
  });
}



class FilePickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: 500,
      child: FilePicker(
        onPathSelected: (path) {
          if(path != null) {
            Navigator.pop(context, path);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}


/// TODO this is the base implementation, this is going to need a few Desktop
/// specific features in the future.
///
/// 1. Resizable, this is not hard to implement, only hover support
/// and setting the cursor image is needed (both implemented with the dart embedder
/// but leaving it out for now)
///
/// 2. Separate window so the File Picker can be dragged around (even outside the main
/// view) independently, also locking the background while it is active would be nice.
/// This depends on multiple window support for Flutter (which is quite hard), though
/// there isn't a need for active data transfer so having a separate isolate would work too
/// (which makes things significantly easier)
class FilePicker extends StatelessWidget {


  FilePicker({Key key, this.onPathSelected}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  final ValueChanged<String> onPathSelected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Material(
        color: theme.backgroundColor,
        child: Column(
          children: <Widget>[
            TextField(
              style: theme.textTheme.body1,
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff323232),
                    width: 2
                  ),
                ),

              ),

            ),
            SizedBox(height: 4,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff323232)
                  )
                ),
                child: FileSystemExplorer(
                  onPathChanged: (path) {
                    textEditingController.text = path;
                  },
                  onPathSelected: (path) {
                    onPathSelected(path);
                  },
                ),
              ),
            ),
            SizedBox(height: 8,),
            Row(
              children: <Widget>[
                Spacer(),
                MaterialButton(
                  color: Color(0xff365880),
                  elevation: 2,
                  child: Text("Ok", style: TextStyle(color: theme.textTheme.body1.color, fontWeight: FontWeight.w600),),
                  onPressed: (){
                    onPathSelected(textEditingController.text);
                  },
                ),
                SizedBox(width: 16,),
                MaterialButton(
                  elevation: 2,
                  color: Color(0xff4c5052),
                  child: Text("Cancle", style: theme.textTheme.body1,),
                  onPressed: (){
                    onPathSelected(null);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


