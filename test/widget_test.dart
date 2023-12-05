// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimme/screens/auth/auth_screen.dart';
import 'package:gimme/screens/auth/signup_screen.dart' as signup;


import 'package:gimme/main.dart';

void main() {
   testWidgets('Register Testing', (WidgetTester tester) async {
    await tester.pump();
    // await tester.tap(find.byKey(const Key('gosignup')));
    // await tester.pumpAndSettle();

    await tester.enterText(find.byKey( const Key('name')), 'Ferdy');
    await tester.enterText(find.byKey( const Key('email')), 'Ferdy@gmail.com');
    await tester.enterText(
        find.byKey(const Key('username')), 'FerdyFirmansyah');
    await tester.enterText(
        find.byKey(const Key('password')), 'FerdyFirmansyah123');
    await tester.enterText(
        find.byKey(const Key('confirm_password')), 'FerdyFirmansyah123');
    await tester.tap(find.byKey(const Key('date')));
    await tester.tap(find.text('OK'));
    await tester.tap(find.byKey(const Key('signUpButton')));
  });
}
