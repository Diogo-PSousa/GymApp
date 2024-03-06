import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fit_friend/firebase_auth.dart';
import 'package:fit_friend/Login_widget.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements Auth{}


void main() {
  group("login_widget tests", () {
    MockAuth mockAuth;

    mockAuth = MockAuth();


    testWidgets('LoginWidget can be built', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginWidget(
          auth: mockAuth,
        ),
      ));

      expect(find.byType(LoginWidget), findsOneWidget);
    });

    testWidgets('LoginWidget shows error message for invalid input', (
        WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginWidget(
          auth: mockAuth,
        ),
      ));

      // Enter invalid email and password
      await tester.enterText(find.byKey(const Key('email_input')), 'invalid_email');
      await tester.enterText(find.byKey(const Key('password_input')), '');

      // Tap login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      // Verify error message is shown
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });
  });
}

