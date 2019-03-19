import 'package:flutter/material.dart';
import 'package:file_system_explorer/src/file_system_explorer_new.dart';

Future<String> showPicker(BuildContext context) {
  return showDialog(context: context, builder: (context) {
    return Dialog(
      child: FilePicker()
    );
  });
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


  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: 500,
      padding: EdgeInsets.all(8),
      child: Material(
        child: Column(
          children: <Widget>[
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(
                    width: 5,
                    color: Colors.red
                  )
                )

              ),

            ),
            SizedBox(height: 4,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                child: FileSystemExplorer(
                  onPathChanged: (path) {
                    textEditingController.text = path;
                  },
                  onPathSelected: (path) {
                    Navigator.pop(context, path);
                  },
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Spacer(),
                RaisedButton(
                  child: Text("Ok"),
                  onPressed: (){
                    Navigator.pop(context, textEditingController.text);
                  },
                ),
                SizedBox(width: 16,),
                RaisedButton(
                  child: Text("Cancle"),
                  onPressed: (){
                    Navigator.pop(context);
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
