import 'package:flutter/material.dart';
import 'country.dart';
import 'countries_data.dart';
import 'phone_number_formatter.dart';

class PhoneNumberController extends ChangeNotifier {
  Country _selectedCountry;
  final TextEditingController numberController = TextEditingController();
  final PhoneNumberFormatter formatter = PhoneNumberFormatter();

  PhoneNumberController({Country? initialCountry})
    : _selectedCountry = initialCountry ?? CountriesData.allCountries.first;

  Country get selectedCountry => _selectedCountry;

  void setCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  String get completeNumber {
    return '${_selectedCountry.dialCode}${numberController.text.replaceAll(RegExp(r'[^\d]'), '')}';
  }

  bool isValid() {
    final cleanNumber = numberController.text.replaceAll(RegExp(r'[^\d]'), '');

    // Basic validation - add more complex validation as needed
    if (cleanNumber.isEmpty) return false;

    // Length validation based on country
    // Length validation based on country
    switch (_selectedCountry.code) {
      case 'AF': // Afghanistan
        return cleanNumber.length == 9;
      case 'AL': // Albania
        return cleanNumber.length == 9;
      case 'DZ': // Algeria
        return cleanNumber.length == 9;
      case 'AD': // Andorra
        return cleanNumber.length == 6;
      case 'AO': // Angola
        return cleanNumber.length == 9;
      case 'AG': // Antigua and Barbuda
        return cleanNumber.length == 10;
      case 'AR': // Argentina
        return cleanNumber.length == 10;
      case 'AM': // Armenia
        return cleanNumber.length == 8;
      case 'AU': // Australia
        return cleanNumber.length == 9;
      case 'AT': // Austria
        return cleanNumber.length >= 10 && cleanNumber.length <= 13;
      case 'AZ': // Azerbaijan
        return cleanNumber.length == 9;
      case 'BS': // Bahamas
        return cleanNumber.length == 10;
      case 'BH': // Bahrain
        return cleanNumber.length == 8;
      case 'BD': // Bangladesh
        return cleanNumber.length == 10;
      case 'BB': // Barbados
        return cleanNumber.length == 10;
      case 'BY': // Belarus
        return cleanNumber.length == 9;
      case 'BE': // Belgium
        return cleanNumber.length == 9;
      case 'BZ': // Belize
        return cleanNumber.length == 7;
      case 'BJ': // Benin
        return cleanNumber.length == 8;
      case 'BT': // Bhutan
        return cleanNumber.length == 8;
      case 'BO': // Bolivia
        return cleanNumber.length == 8;
      case 'BA': // Bosnia and Herzegovina
        return cleanNumber.length == 8;
      case 'BW': // Botswana
        return cleanNumber.length == 8;
      case 'BR': // Brazil
        return cleanNumber.length == 11;
      case 'BN': // Brunei
        return cleanNumber.length == 7;
      case 'BG': // Bulgaria
        return cleanNumber.length == 9;
      case 'BF': // Burkina Faso
        return cleanNumber.length == 8;
      case 'BI': // Burundi
        return cleanNumber.length == 8;
      case 'KH': // Cambodia
        return cleanNumber.length == 9;
      case 'CM': // Cameroon
        return cleanNumber.length == 9;
      case 'CA': // Canada
        return cleanNumber.length == 10;
      case 'CV': // Cape Verde
        return cleanNumber.length == 7;
      case 'CF': // Central African Republic
        return cleanNumber.length == 8;
      case 'TD': // Chad
        return cleanNumber.length == 8;
      case 'CL': // Chile
        return cleanNumber.length == 9;
      case 'CN': // China
        return cleanNumber.length == 11;
      case 'CO': // Colombia
        return cleanNumber.length == 10;
      case 'KM': // Comoros
        return cleanNumber.length == 7;
      case 'CG': // Congo
        return cleanNumber.length == 9;
      case 'CD': // Democratic Republic of the Congo
        return cleanNumber.length == 9;
      case 'CR': // Costa Rica
        return cleanNumber.length == 8;
      case 'HR': // Croatia
        return cleanNumber.length == 9;
      case 'CU': // Cuba
        return cleanNumber.length == 8;
      case 'CY': // Cyprus
        return cleanNumber.length == 8;
      case 'CZ': // Czech Republic
        return cleanNumber.length == 9;
      case 'DK': // Denmark
        return cleanNumber.length == 8;
      case 'DJ': // Djibouti
        return cleanNumber.length == 8;
      case 'DM': // Dominica
        return cleanNumber.length == 10;
      case 'DO': // Dominican Republic
        return cleanNumber.length == 10;
      case 'EC': // Nicaragua
        return cleanNumber.length == 8;
      case 'EG': // Egypt
        return cleanNumber.length == 10;
      case 'SV': // El Salvador
        return cleanNumber.length == 8;
      case 'GQ': // Equatorial Guinea
        return cleanNumber.length == 9;
      case 'ER': // Eritrea
        return cleanNumber.length == 7;
      case 'EE': // Estonia
        return cleanNumber.length == 8;
      case 'SZ': // Eswatini
        return cleanNumber.length == 8;
      case 'ET': // Ethiopia
        return cleanNumber.length == 9;
      case 'FJ': // Fiji
        return cleanNumber.length == 7;
      case 'FI': // Finland
        return cleanNumber.length == 9;
      case 'FR': // France
        return cleanNumber.length == 9;
      case 'GA': // Gabon
        return cleanNumber.length == 7;
      case 'GM': // Gambia
        return cleanNumber.length == 7;
      case 'GE': // Georgia
        return cleanNumber.length == 9;
      case 'DE': // Germany
        return cleanNumber.length >= 10 && cleanNumber.length <= 11;
      case 'GH': // Ghana
        return cleanNumber.length == 9;
      case 'GR': // Greece
        return cleanNumber.length == 10;
      case 'GD': // Grenada
        return cleanNumber.length == 10;
      case 'GT': // Guatemala
        return cleanNumber.length == 8;
      case 'GN': // Guinea
        return cleanNumber.length == 9;
      case 'GW': // Guinea-Bissau
        return cleanNumber.length == 9;
      case 'GY': // Guyana
        return cleanNumber.length == 7;
      case 'HT': // Haiti
        return cleanNumber.length == 8;
      case 'HN': // Honduras
        return cleanNumber.length == 8;
      case 'HU': // Hungary
        return cleanNumber.length == 9;
      case 'IS': // Iceland
        return cleanNumber.length == 7;
      // case 'IN': // India
      //   return cleanNumber.length == 10;
      case 'ID': // Indonesia
        return cleanNumber.length >= 9 && cleanNumber.length <= 12;
      case 'IR': // Iran
        return cleanNumber.length == 10;
      case 'IQ': // Iraq
        return cleanNumber.length == 10;
      case 'IE': // Ireland
        return cleanNumber.length == 9;
      // case 'IL': // Israel
      //   return cleanNumber.length == 9;
      case 'IT': // Italy
        return cleanNumber.length == 10;
      case 'JM': // Jamaica
        return cleanNumber.length == 10;
      case 'JP': // Japan
        return cleanNumber.length == 10;
      case 'JO': // Jordan
        return cleanNumber.length == 9;
      case 'KZ': // Kazakhstan
        return cleanNumber.length == 10;
      case 'KE': // Kenya
        return cleanNumber.length == 9;
      case 'KI': // Kiribati
        return cleanNumber.length == 8;
      case 'KW': // Kuwait
        return cleanNumber.length == 8;
      case 'KG': // Kyrgyzstan
        return cleanNumber.length == 9;
      case 'LA': // Laos
        return cleanNumber.length == 8;
      case 'LV': // Latvia
        return cleanNumber.length == 8;
      case 'LB': // Lebanon
        return cleanNumber.length == 8;
      case 'LS': // Lesotho
        return cleanNumber.length == 8;
      case 'LR': // Liberia
        return cleanNumber.length == 9;
      case 'LY': // Libya
        return cleanNumber.length == 9;
      case 'LI': // Liechtenstein
        return cleanNumber.length == 7;
      case 'LT': // Lithuania
        return cleanNumber.length == 8;
      case 'LU': // Luxembourg
        return cleanNumber.length == 9;
      case 'MG': // Madagascar
        return cleanNumber.length == 9;
      case 'MW': // Malawi
        return cleanNumber.length == 9;
      case 'MY': // Malaysia
        return cleanNumber.length >= 9 && cleanNumber.length <= 10;
      case 'MV': // Maldives
        return cleanNumber.length == 7;
      case 'ML': // Mali
        return cleanNumber.length == 8;
      case 'MT': // Malta
        return cleanNumber.length == 8;
      case 'MH': // Marshall Islands
        return cleanNumber.length == 7;
      case 'MR': // Mauritania
        return cleanNumber.length == 8;
      case 'MU': // Mauritius
        return cleanNumber.length == 8;
      case 'MX': // Mexico
        return cleanNumber.length == 10;
      case 'FM': // Micronesia
        return cleanNumber.length == 7;
      case 'MD': // Moldova
        return cleanNumber.length == 8;
      case 'MC': // Monaco
        return cleanNumber.length == 8;
      case 'MN': // Mongolia
        return cleanNumber.length == 8;
      case 'ME': // Montenegro
        return cleanNumber.length == 8;
      case 'MA': // Morocco
        return cleanNumber.length == 9;
      case 'MZ': // Mozambique
        return cleanNumber.length == 9;
      case 'MM': // Myanmar
        return cleanNumber.length == 9;
      case 'NA': // Namibia
        return cleanNumber.length == 9;
      case 'NR': // Nauru
        return cleanNumber.length == 7;
      case 'NP': // Nepal
        return cleanNumber.length == 10;
      case 'NL': // Netherlands
        return cleanNumber.length == 9;
      case 'NZ': // New Zealand
        return cleanNumber.length >= 8 && cleanNumber.length <= 9;
      case 'NI': // Nicaragua
        return cleanNumber.length == 8;
      case 'NE': // Niger
        return cleanNumber.length == 8;
      case 'NG': // Nigeria
        return cleanNumber.length == 10;
      case 'KP': // North Korea
        return cleanNumber.length == 10;
      case 'MK': // North Macedonia
        return cleanNumber.length == 8;
      case 'NO': // Norway
        return cleanNumber.length == 8;
      case 'OM': // Oman
        return cleanNumber.length == 8;
      case 'PK': // Pakistan
        return cleanNumber.length == 10;
      case 'PW': // Palau
        return cleanNumber.length == 7;
      case 'PS': // Palestine
        return cleanNumber.length == 9;
      case 'PA': // Panama
        return cleanNumber.length == 8;
      case 'PG': // Papua New Guinea
        return cleanNumber.length == 8;
      case 'PY': // Paraguay
        return cleanNumber.length == 9;
      case 'PE': // Peru
        return cleanNumber.length == 9;
      case 'PH': // Philippines
        return cleanNumber.length == 10;
      case 'PL': // Poland
        return cleanNumber.length == 9;
      case 'PT': // Portugal
        return cleanNumber.length == 9;
      case 'QA': // Qatar
        return cleanNumber.length == 8;
      case 'RO': // Romania
        return cleanNumber.length == 9;
      case 'RU': // Russia
        return cleanNumber.length == 10;
      case 'RW': // Rwanda
        return cleanNumber.length == 9;
      case 'KN': // Saint Kitts and Nevis
        return cleanNumber.length == 10;
      case 'LC': // Saint Lucia
        return cleanNumber.length == 10;
      case 'VC': // Saint Vincent and the Grenadines
        return cleanNumber.length == 10;
      case 'WS': // Samoa
        return cleanNumber.length == 7;
      case 'SM': // San Marino
        return cleanNumber.length == 10;
      case 'ST': // Sao Tome and Principe
        return cleanNumber.length == 7;
      case 'SA': // Saudi Arabia
        return cleanNumber.length == 9;
      case 'SN': // Senegal
        return cleanNumber.length == 9;
      case 'RS': // Serbia
        return cleanNumber.length == 9;
      case 'SC': // Seychelles
        return cleanNumber.length == 7;
      case 'SL': // Sierra Leone
        return cleanNumber.length == 8;
      case 'SG': // Singapore
        return cleanNumber.length == 8;
      case 'SK': // Slovakia
        return cleanNumber.length == 9;
      case 'SI': // Slovenia
        return cleanNumber.length == 8;
      case 'SB': // Solomon Islands
        return cleanNumber.length == 7;
      case 'SO': // Somalia
        return cleanNumber.length == 9;
      case 'ZA': // South Africa
        return cleanNumber.length == 9;
      case 'KR': // South Korea
        return cleanNumber.length == 10;
      case 'SS': // South Sudan
        return cleanNumber.length == 9;
      case 'ES': // Spain
        return cleanNumber.length == 9;
      case 'LK': // Sri Lanka
        return cleanNumber.length == 9;
      case 'SD': // Sudan
        return cleanNumber.length == 9;
      case 'SR': // Suriname
        return cleanNumber.length == 7;
      case 'SE': // Sweden
        return cleanNumber.length == 9;
      case 'CH': // Switzerland
        return cleanNumber.length == 9;
      case 'SY': // Syria
        return cleanNumber.length == 9;
      case 'TW': // Taiwan
        return cleanNumber.length == 9;
      case 'TJ': // Tajikistan
        return cleanNumber.length == 9;
      case 'TZ': // Tanzania
        return cleanNumber.length == 9;
      case 'TH': // Thailand
        return cleanNumber.length == 9;
      case 'TL': // Timor-Leste
        return cleanNumber.length == 8;
      case 'TG': // Togo
        return cleanNumber.length == 8;
      case 'TO': // Tonga
        return cleanNumber.length == 7;
      case 'TT': // Trinidad and Tobago
        return cleanNumber.length == 10;
      case 'TN': // Tunisia
        return cleanNumber.length == 8;
      case 'TR': // Turkey
        return cleanNumber.length == 10;
      case 'TM': // Turkmenistan
        return cleanNumber.length == 8;
      case 'TV': // Tuvalu
        return cleanNumber.length == 6;
      case 'UG': // Uganda
        return cleanNumber.length == 9;
      case 'UA': // Ukraine
        return cleanNumber.length == 9;
      case 'AE': // United Arab Emirates
        return cleanNumber.length == 9;
      case 'GB': // United Kingdom
        return cleanNumber.length >= 9 && cleanNumber.length <= 10;
      case 'US': // United States
        return cleanNumber.length == 10;
      case 'UY': // Uruguay
        return cleanNumber.length == 8;
      case 'UZ': // Uzbekistan
        return cleanNumber.length == 9;
      case 'VU': // Vanuatu
        return cleanNumber.length == 7;
      case 'VE': // Venezuela
        return cleanNumber.length == 10;
      case 'VN': // Vietnam
        return cleanNumber.length == 10;
      case 'YE': // Yemen
        return cleanNumber.length == 9;
      case 'ZM': // Zambia
        return cleanNumber.length == 9;
      case 'ZW': // Zimbabwe
        return cleanNumber.length == 9;
      default:
        return cleanNumber.length >= 5; // Generic fallback
    }
  }

  void formatPhoneNumber() {
    final text = numberController.text;
    final selection = numberController.selection;

    final formattedText = formatter.format(text, _selectedCountry.code);

    // Keep cursor position
    final difference = formattedText.length - text.length;

    numberController.text = formattedText;

    if (selection.baseOffset > -1) {
      numberController.selection = TextSelection.collapsed(
        offset: selection.baseOffset + difference,
      );
    }
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }
}
