import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimme/screens/auth/signin_screen.dart';
import 'package:gimme/screens/auth/signup_screen.dart';
import 'dart:io';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Register Testing', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));
    Future<void> enterTextFormField(Key key, String text) async {
      final textField = find.byKey(key);
      await tester.enterText(textField, text);
      await tester.pumpAndSettle();
    }
    await enterTextFormField(const Key('name'), 'rossi');
    await enterTextFormField(const Key('email'), 'rosi@gmail.com');
    await enterTextFormField(const Key('username'), 'Rossi');
    await enterTextFormField(const Key('password'), '123123');
    await enterTextFormField(const Key('confirm_password'), '123123');

    await tester.tap(find.byKey(const Key('date')));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.text('OK').last);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.dragUntilVisible(find.text("Sign In"),
        find.byType(SingleChildScrollView), const Offset(382.9, 584.0));    
    await tester.pumpAndSettle(const Duration(seconds: 10));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byType(SignInScreen), findsOneWidget);
  });
}

