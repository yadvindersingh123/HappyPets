import 'package:HAPPYPETS/main.dart';
import 'package:HAPPYPETS/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash redirects to phone-only login without a back route',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(Login), findsNothing);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Sign in with phone number'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Email'), findsNothing);
    expect(find.text('Password'), findsNothing);
    expect(Navigator.of(tester.element(find.byType(Login))).canPop(), isFalse);
  });

  testWidgets('Phone login rejects empty and incomplete phone numbers',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Login()));
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.text('Please enter your phone number'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), '12345');
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.text('Enter a valid 10-digit phone number'), findsOneWidget);
    expect(find.byType(Login), findsOneWidget);
  });

  testWidgets('Disposing splash cancels its redirect', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pump(const Duration(seconds: 4));
    expect(tester.takeException(), isNull);
    expect(find.byType(Login), findsNothing);
  });
}
