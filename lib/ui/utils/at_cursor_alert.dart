import 'package:flutter/material.dart';
import 'package:flutter_desktop_widgets2/flutter_desktop_widgets2.dart';

void showDidNotAccept(BuildContext context) => showAlertAtCursor(context, "Not accepted");

void showAlertAtCursor(BuildContext context, String alert) {
  var position = CursorPositionWidget.of(context);
  OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) {
      return _FadingOverlay(
        entry: entry,
        position: position,
        text: alert,
      );
    },
  );


  Navigator.of(context).overlay.insert(entry);
}


class _FadingOverlay extends StatefulWidget {

  final OverlayEntry entry;
  final String text;
  final Offset position;

  const _FadingOverlay({Key key, this.entry, this.text, this.position}) : super(key: key);

  @override
  __FadingOverlayState createState() => __FadingOverlayState();
}

class __FadingOverlayState extends State<_FadingOverlay> {

  bool visible = true;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  Future startCountdown() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      visible = false;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    widget.entry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position.dy,
      left: widget.position.dx,
      child: AnimatedOpacity(
        opacity: visible? 1: 0,
        duration: const Duration(milliseconds: 200),
        child: Material(color: Colors.transparent, child: Text(widget.text)),
      ),
    );
  }
}
