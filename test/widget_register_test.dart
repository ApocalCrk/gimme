import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimme/routes/AppRoute.dart';
import 'package:gimme/screens/auth/signup_screen.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
  });
  testWidgets('Sign Up', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
      onGenerateRoute: AppRoute.generateRoute,
    ));

    await tester.enterText(find.byKey(const Key('name')), "ferdy");
    await tester.enterText(find.byKey(const Key('username')), "ferdya");
    await tester.enterText(find.byKey(const Key('email')), "ferdy@gmail.com");
    await tester.enterText(find.byKey(const Key('username')), "ferdya");
    await tester.enterText(find.byKey(const Key('password')), "fa");
    await tester.enterText(find.byKey(const Key('confirm_password')), "fa");
    await tester.dragUntilVisible(find.text("Sign Up"),
        find.byType(SingleChildScrollView), const Offset(400.0, 621.0));
    await tester.tap(find.byKey(const Key('date')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('OK').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text("Let's Sign you in."), findsOneWidget);
  });
}