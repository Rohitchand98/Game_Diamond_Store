// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:harisdiam/main.dart';

import 'dart:io';

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  testWidgets('HarisdiamApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HarisdiamApp());
    // Allow animations to settle (loading images etc)
    await tester.pumpAndSettle();

    // Verify that the app builds and shows the home screen.
    // referencing text from DiamondStoreScreen
    expect(find.text('Enter Your Account Details'), findsOneWidget);
    expect(find.text('Select Package'), findsOneWidget);
    expect(find.text('Buy Now'), findsOneWidget);
  });
}
