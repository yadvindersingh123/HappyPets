import 'package:HAPPYPETS/screens/AddPet3.dart';
import 'package:HAPPYPETS/screens/LoginScreen.dart';
import 'package:HAPPYPETS/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Phone submission opens OTP and allows correcting the number',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Login()));
    await tester.enterText(find.byType(TextFormField), '9876543210');
    expect(find.text('India (+91)'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(OtpScreen), findsNothing);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNull);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(OtpScreen), findsOneWidget);
    expect(find.textContaining('+91 9876543210'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('9876543210'), findsOneWidget);
  });

  testWidgets('Selected country code is passed to OTP', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Login()));
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('United Kingdom (+44)').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '7700900123');
    await tester.tap(find.text('Continue'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.textContaining('+44 7700900123'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Leaving login during loading cancels navigation',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Login()));
    await tester.enterText(find.byType(TextFormField), '9876543210');
    await tester.tap(find.text('Continue'));
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pump(const Duration(seconds: 2));
    expect(tester.takeException(), isNull);
    expect(find.byType(OtpScreen), findsNothing);
  });

  testWidgets('Only 123456 verifies, with a loader before pet setup',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OtpScreen()));
    await tester.tap(find.text('Verify OTP'));
    await tester.pump();
    expect(find.text('Please enter the 6-digit OTP.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '654321');
    await tester.tap(find.text('Verify OTP'));
    await tester.pump();
    expect(find.text('Incorrect OTP. Please try again.'), findsOneWidget);
    expect(find.byType(Addpet3), findsNothing);
    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Verify OTP'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Addpet3), findsNothing);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(Addpet3), findsOneWidget);
    expect(
        Navigator.of(tester.element(find.byType(Addpet3))).canPop(), isFalse);
  });

  testWidgets('Resend unlocks after 60 seconds and retains the same OTP',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OtpScreen()));
    expect(
        tester.widget<TextButton>(find.byType(TextButton)).onPressed, isNull);
    await tester.pump(const Duration(seconds: 59));
    expect(find.text('Resend OTP in 1s'), findsOneWidget);
    expect(
        tester.widget<TextButton>(find.byType(TextButton)).onPressed, isNull);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('Resend OTP'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNull);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('OTP sent.'), findsOneWidget);
    expect(find.text('Resend OTP in 60s'), findsOneWidget);
    expect(
        tester.widget<TextButton>(find.byType(TextButton)).onPressed, isNull);
    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Verify OTP'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(Addpet3), findsOneWidget);
  });

  testWidgets('Leaving OTP during resend cancels pending work', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OtpScreen()));
    await tester.pump(const Duration(seconds: 60));
    await tester.tap(find.text('Resend OTP'));
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pump(const Duration(seconds: 2));
    expect(tester.takeException(), isNull);
  });
}
