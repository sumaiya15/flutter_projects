// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:color_changingbox_app/colorful_box.dart'; // Import the ColorfulBox widget.

void main() {
  testWidgets('ColorfulBox color changes on tap', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( const MaterialApp(
      home: ColorfulBox(), // Use the ColorfulBox widget as the main widget.
    ));

    // Verify that the initial color of the box is blue (as defined in ColorfulBox).
    expect(find.byType(Container), findsOneWidget);
    expect((tester.firstWidget(find.byType(Container)) as Container).color, Colors.blue);

    // Tap the 'Change Color' button and trigger a frame.
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Verify that the color of the box has changed.
    expect((tester.firstWidget(find.byType(Container)) as Container).color, isNot(Colors.blue));
  });
}

