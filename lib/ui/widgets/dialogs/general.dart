import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  const DialogOption({Key key, this.onTap, this.text, this.leading}) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(leading != null) Padding(child: leading, padding: EdgeInsets.only(right: 8),),
               Text(text),
            ],
          ),
        ),
      ),
    );
  }
}