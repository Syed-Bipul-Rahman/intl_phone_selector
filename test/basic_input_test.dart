// test/basic_input_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

void main() {
  testWidgets('BasicPhoneInput displays correctly',
      (WidgetTester tester) async {
    final controller = PhoneNumberController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BasicPhoneInput(
            controller: controller,
          ),
        ),
      ),
    );

    // Verify flag and dial code are displayed
    expect(find.text('🇺🇸'), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);

    // Verify text field exists
    expect(find.byType(TextField), findsOneWidget);

    // Clean up
    controller.dispose();
  });

  testWidgets('BasicPhoneInput handles text input',
      (WidgetTester tester) async {
    final controller = PhoneNumberController();
    bool validationResult = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BasicPhoneInput(
            controller: controller,
            onValidationChanged: (isValid) {
              validationResult = isValid;
            },
          ),
        ),
      ),
    );

    // Enter phone number
    await tester.enterText(find.byType(TextField), '1234567890');
    await tester.pump();

    // Check if formatting is applied
    expect(controller.numberController.text, '(123) 456-7890');

    // Check if validation callback fired
    expect(validationResult, true);

    // Clean up
    controller.dispose();
  });
}
