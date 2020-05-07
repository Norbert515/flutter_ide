// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widget_maker_2_0/main.dart';

void main() {
  setUp(() {
    // Add this when running the test
    //debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  });
  testWidgets('Pop up project dialog', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(), const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Find the title
    expect(find.text("Widget Maker"), findsOneWidget);
    expect(find.text("Pixel 2"), findsOneWidget);

    await tester.tap(find.text("Pixel 2"));
    await tester.pumpAndSettle();

    expect(find.text("Widget Maker"), findsNothing);

  });

  testWidgets('Dialog dissapears when tapped on the background', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp(), const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.text("Widget Maker"), findsOneWidget);
    expect(find.text("Pixel 2"), findsOneWidget);

    await tester.tapAt(Offset(0, 0));
    await tester.pumpAndSettle();

    expect(find.text("Widget Maker"), findsNothing);
  });


  testWidgets('Dialog screensize selection works', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp(), const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Pixel 2"));
    await tester.pumpAndSettle();
    
    expect(find.text("Canvas"), findsOneWidget);

    await tester.tap(find.text("Canvas"));
    await tester.pump();

    // Find the size which the Pixel 2 has in the Canvas Property Editor
    expect(find.text("411.00"), findsOneWidget);
    expect(find.text("731.00"), findsOneWidget);

    // Finds the drop down Pixel 2
    expect(find.text("Pixel 2"), findsOneWidget);



    await tester.pumpAndSettle(Duration(seconds: 5));

  });
}
