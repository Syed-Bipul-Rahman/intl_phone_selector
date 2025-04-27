import 'country.dart';
import 'countries_data.dart';

extension PhoneNumberStringExtension on String {
  Country? tryGetCountry() {
    if (isEmpty) return null;

    // Check if string starts with '+'
    if (startsWith('+')) {
      // Find the first non-digit character or end of string
      int endIndex = 1;
      while (endIndex < length && isDigit(this[endIndex])) {
        endIndex++;
      }

      // Extract the dial code
      String dialCode = substring(0, endIndex);

      try {
        return CountriesData.getCountryByDialCode(dialCode);
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  bool isDigit(String s) {
    if (s.isEmpty) return false;
    return int.tryParse(s) != null;
  }
}
