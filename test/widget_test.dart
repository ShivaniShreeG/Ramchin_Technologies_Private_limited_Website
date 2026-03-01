import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ramchin_web/main.dart';

void main() {
  testWidgets('MyWebApp builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyWebApp());

    // App loads
    expect(find.byType(MaterialApp), findsOneWidget);

    // App title exists
    expect(find.text('Ramchin Technologies Pvt Ltd'), findsOneWidget);
  });
}