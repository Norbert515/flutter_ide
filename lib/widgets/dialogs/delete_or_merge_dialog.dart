import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';

import 'general.dart';

enum DeleteOperation {
  deleteSubtree,
  replaceWithChild,
}


Future<DeleteOperation> showDeleteOperationDialog(BuildContext context) {
  return showDialogAtCursor<DeleteOperation>(
    size: Size(200,100),
    builder: (context) {
      return _DeleteOrMergeDialog();
    },
    context: context,
  );
}


class _DeleteOrMergeDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            DialogOption(
              onTap: () {
                Navigator.of(context).pop(DeleteOperation.deleteSubtree);
              },
              text: "Delete Subtree",
            ),
            DialogOption(
              onTap: () {
                Navigator.of(context).pop(DeleteOperation.replaceWithChild);
              },
              text: "Replace with child",
            ),
          ],
        ),
      ),
    );
  }
}


