import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/modules/theme.dart';
import 'package:widget_maker_2_0/properties/meta_properties.dart';
import 'package:widget_maker_2_0/properties/value_changers/widgets/number_changer.dart';

class NewCanvasDialogResult {
  final String name;
  final CanvasSize canvasSize;

  NewCanvasDialogResult({this.name, this.canvasSize});
}



class NewCanvasDialog extends StatefulWidget {
  @override
  _NewCanvasDialogState createState() => _NewCanvasDialogState();
}

class _NewCanvasDialogState extends State<NewCanvasDialog> {


  CanvasSize canvasSize = CanvasSize(width: 411, height: 731);
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MyTheme.of(context).background16dp,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("New Canvas"),
            SizedBox(height: 32,),
            TextField(
              maxLines: 1,
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Canvas name",
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: <Widget>[
                Expanded(
                  child: NumberChanger(
                    updateEveryChange: true,
                    value: canvasSize.width,
                    name: "Width",
                    onUpdate: (it) {
                      canvasSize = canvasSize.copyWith(width: it);
                    },
                  ),
                ),
                Spacer(),
                Expanded(
                  child: NumberChanger(
                    updateEveryChange: true,
                    value: canvasSize.height,
                    name: "Height",
                    onUpdate: (it) {
                      canvasSize = canvasSize.copyWith(height: it);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop(NewCanvasDialogResult(
                      name: nameController.text,
                      canvasSize: canvasSize,
                    ));
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