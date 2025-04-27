import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

void main() {
  group('PhoneNumberController Tests', () {
    late PhoneNumberController controller;

    setUp(() {
      controller = PhoneNumberController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Initial country selection', () {
      expect(controller.selectedCountry.code, 'US');
    });

    test('Change country', () {
      final newCountry = Country(
        name: 'Bangladesh',
        code: 'BD',
        dialCode: '+880',
        flagEmoji: '🇧🇩',
      );

      controller.setCountry(newCountry);
      expect(controller.selectedCountry.code, 'BD');
    });

    test('Complete number formatting', () {
      controller.numberController.text = '1234567890';
      expect(controller.completeNumber, '+11234567890');

      final indiaCountry = Country(
        name: 'Bangladesh',
        code: 'BD',
        dialCode: '+880',
        flagEmoji: '🇧🇩',
      );

      controller.setCountry(indiaCountry);
      expect(controller.completeNumber, '+8801234567890');
    });

    test('US number validation', () {
      // Invalid - too short
      controller.numberController.text = '123456789';
      expect(controller.isValid(), false);

      // Valid
      controller.numberController.text = '1234567890';
      expect(controller.isValid(), true);

      // Invalid - too long
      controller.numberController.text = '12345678901';
      expect(controller.isValid(), false);
    });

    test('India number validation', () {
      final indiaCountry = Country(
        name: 'Bangladesh',
        code: 'BD',
        dialCode: '+880',
        flagEmoji: '🇧🇩',
      );

      controller.setCountry(indiaCountry);

      // Invalid - too short
      controller.numberController.text = '123456789';
      expect(controller.isValid(), false);

      // Valid
      controller.numberController.text = '1234567890';
      expect(controller.isValid(), true);
    });
  });

  group('PhoneNumberFormatter Tests', () {
    final formatter = PhoneNumberFormatter();

    test('US number formatting', () {
      expect(formatter.format('1234567890', 'US'), '(123) 456-7890');
      expect(formatter.format('123456', 'US'), '(123) 456');
      expect(formatter.format('123', 'US'), '123');
    });

    test('Bangladesh number formatting', () {
      expect(formatter.format('1234567890', 'BD'), '12345 67890');
      expect(formatter.format('123456', 'BD'), '12345 6');
    });
  });
}
