// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widget_maker_2_0/main.dart';

void main() {
  testWidgets('Drag and drop circular progress indicator from widget dialog in empty canvas', (WidgetTester tester) async {

    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    // Build our app and trigger a frame.
    var app = MyApp();
    await tester.pumpWidget(app, const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Tap away welcome dialog
    await tester.tapAt(Offset(0, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.text("New Widget (or ctrl+space)"));
    await tester.pump(Duration(seconds: 1));

    final gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
    );
    //await gesture.addPointer();

    //await gesture.moveTo(Offset.zero,);
    await tester.tap(find.text(("Text")));
    await tester.pump(Duration(seconds: 1));

    /*// TODO hovering with the mouse doesnt work right now
    await tester.dragFrom(tester.getCenter(find.byWidget(app)), tester.getCenter(find.byWidget(app)));
    await tester.tapAt(tester.getCenter(find.byWidget(app)));
    await tester.pump();
    */


    await gesture.moveTo(Offset.zero);
    await gesture.moveBy(Offset(250, 250));

    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.text('Not accepted'), findsOneWidget);


  });
}