import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimme/routes/AppRoute.dart';
import 'package:gimme/screens/auth/signin_screen.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
  });

  testWidgets('Login', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignInScreen(),
      onGenerateRoute: AppRoute.generateRoute,
    ));

    await tester.enterText(find.byType(TextFormField).first, "ferdy");
    await tester.enterText(find.byType(TextFormField).last, "ferdy");
    await tester.pumpAndSettle();

    await tester.tap(find.text("Sign In"));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    
    expect(find.text("Hello, Ferdy Firmansyah!"), findsOneWidget);
  });
}