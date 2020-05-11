import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {

  const TopBar({Key key, this.showVisual, this.onUpdate}) : super(key: key);

  final bool showVisual;

  final ValueChanged<bool> onUpdate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        margin: const EdgeInsets.all(0),
        color: Theme.of(context).accentColor,
        child: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: Theme.of(context).accentIconTheme,
          ),
          child: Row(
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(Icons.transform),
                onPressed: () => onUpdate(true),
              ),
              VerticalDivider(),
              IconButton(
                icon: Icon(Icons.code),
                onPressed: () => onUpdate(false),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
