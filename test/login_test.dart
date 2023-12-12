import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gimme/screens/auth/signin_screen.dart';
import 'package:gimme/screens/dashboard/dashboard.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  testWidgets("Login Testing", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignInScreen(),
    ));

    await tester.enterText(find.byType(TextFormField).first, "trisna");
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).last, "111111");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Sign In"));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byType(Dashboard), findsOneWidget);

  });

}