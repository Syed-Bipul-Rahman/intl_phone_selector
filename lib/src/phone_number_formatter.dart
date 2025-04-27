class PhoneNumberFormatter {
  String format(String text, String countryCode) {
    final digitsOnly = text.replaceAll(RegExp(r'[^\d]'), '');

    switch (countryCode) {
      case 'US':
      case 'CA':
      case 'AG':
      case 'BS':
      case 'BB':
      case 'DM':
      case 'DO':
      case 'GD':
      case 'JM':
      case 'KN':
      case 'LC':
      case 'VC':
      case 'TT':
        return _formatNorthAmerican(digitsOnly);
      // case 'IN':
      case 'BD':
      case 'EG':
      case 'IQ':
      case 'IR':
      case 'JP':
      case 'KZ':
      case 'MX':
      case 'NG':
      case 'NP':
      case 'PK':
      case 'PH':
      case 'RU':
      case 'TR':
      case 'VE':
      case 'VN':
      case 'AR':
      case 'CO':
      case 'KP':
      case 'SM':
        return _formatTenDigit(digitsOnly);
      case 'GB':
      case 'IE':
      case 'AU':
      case 'NZ':
      case 'MY':
        return _formatUK(digitsOnly);
      case 'CN':
      case 'BR':
        return _formatElevenDigit(digitsOnly);
      case 'DE':
      case 'AT':
      case 'ID':
        return _formatVariable(digitsOnly, 4, 11);
      case 'FR':
      case 'BE':
      case 'CH':
      case 'ES':
      case 'IT':
      case 'NL':
      case 'PT':
      case 'SE':
      case 'AF':
      case 'AL':
      case 'DZ':
      case 'AM':
      case 'AZ':
      case 'BY':
      case 'BG':
      case 'CL':
      case 'ET':
      case 'FI':
      case 'GE':
      case 'GH':
      case 'GR':
      case 'HU':
      case 'JO':
      case 'KE':
      case 'KG':
      case 'LR':
      case 'LY':
      case 'LU':
      case 'MG':
      case 'MW':
      case 'MA':
      case 'MZ':
      case 'MM':
      case 'NA':
      case 'PE':
      case 'PL':
      case 'PY':
      case 'RO':
      case 'RW':
      case 'SA':
      case 'SN':
      case 'RS':
      case 'SK':
      case 'SO':
      case 'ZA':
      case 'KR':
      case 'SS':
      case 'LK':
      case 'SD':
      case 'SY':
      case 'TW':
      case 'TJ':
      case 'TZ':
      case 'TH':
      case 'UA':
      case 'AE':
      case 'UZ':
      case 'YE':
      case 'ZM':
      case 'ZW':
        return _formatNineDigit(digitsOnly);
      case 'BO':
      case 'BW':
      case 'BF':
      case 'BI':
      case 'KH':
      case 'CM':
      case 'CF':
      case 'TD':
      case 'CG':
      case 'CD':
      case 'CR':
      case 'HR':
      case 'CU':
      case 'CY':
      case 'CZ':
      case 'DJ':
      case 'SV':
      case 'GQ':
      case 'GN':
      case 'GW':
      case 'GT':
      case 'HN':
      case 'KI':
      case 'KW':
      case 'LA':
      case 'LV':
      case 'LS':
      case 'LT':
      case 'ML':
      case 'MT':
      case 'MR':
      case 'MU':
      case 'MD':
      case 'MC':
      case 'MN':
      case 'ME':
      case 'MK':
      case 'NO':
      case 'OM':
      case 'PA':
      case 'PG':
      case 'QA':
      case 'SI':
      case 'SL':
      case 'SG':
      case 'TL':
      case 'TG':
      case 'TM':
      case 'TN':
      case 'UY':
        return _formatEightDigit(digitsOnly);
      case 'BN':
      case 'BZ':
      case 'CV':
      case 'KM':
      case 'ER':
      case 'FJ':
      case 'GA':
      case 'GM':
      case 'GY':
      case 'IS':
      case 'MV':
      case 'MH':
      case 'FM':
      case 'NR':
      case 'PW':
      case 'WS':
      case 'SC':
      case 'ST':
      case 'TO':
      case 'VU':
        return _formatSevenDigit(digitsOnly);
      case 'AD':
      case 'TV':
        return _formatSixDigit(digitsOnly);
      case 'DK':
        return _formatDanish(digitsOnly);
      default:
        return digitsOnly;
    }
  }

  String _formatNorthAmerican(String digitsOnly) {
    // Format: (XXX) XXX-XXXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 4) return digitsOnly;
    if (digitsOnly.length < 7)
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
    return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, digitsOnly.length.clamp(0, 10))}';
  }

  String _formatUK(String digitsOnly) {
    // Format: XXXX XXXXXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 5) return digitsOnly;
    return '${digitsOnly.substring(0, 4)} ${digitsOnly.substring(4, digitsOnly.length.clamp(0, 10))}';
  }

  String _formatNineDigit(String digitsOnly) {
    // Format: XXX XXX XXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 4) return digitsOnly;
    if (digitsOnly.length < 7)
      return '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3)}';
    return '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3, 6)} ${digitsOnly.substring(6, digitsOnly.length.clamp(0, 9))}';
  }

  String _formatTenDigit(String digitsOnly) {
    // Format: XXXXX XXXXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 6) return digitsOnly;
    return '${digitsOnly.substring(0, 5)} ${digitsOnly.substring(5, digitsOnly.length.clamp(0, 10))}';
  }

  String _formatElevenDigit(String digitsOnly) {
    // Format: XXXX XXX XXXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 5) return digitsOnly;
    if (digitsOnly.length < 8)
      return '${digitsOnly.substring(0, 4)} ${digitsOnly.substring(4)}';
    return '${digitsOnly.substring(0, 4)} ${digitsOnly.substring(4, 7)} ${digitsOnly.substring(7, digitsOnly.length.clamp(0, 11))}';
  }

  String _formatEightDigit(String digitsOnly) {
    // Format: XXXX XXXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 5) return digitsOnly;
    return '${digitsOnly.substring(0, 4)} ${digitsOnly.substring(4, digitsOnly.length.clamp(0, 8))}';
  }

  String _formatSevenDigit(String digitsOnly) {
    // Format: XXX XXXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 4) return digitsOnly;
    return '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3, digitsOnly.length.clamp(0, 7))}';
  }

  String _formatSixDigit(String digitsOnly) {
    // Format: XXX XXX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 4) return digitsOnly;
    return '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3, digitsOnly.length.clamp(0, 6))}';
  }

  String _formatDanish(String digitsOnly) {
    // Format: XX XX XX XX
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < 3) return digitsOnly;
    if (digitsOnly.length < 5)
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2)}';
    if (digitsOnly.length < 7)
      return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 4)} ${digitsOnly.substring(4)}';
    return '${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 4)} ${digitsOnly.substring(4, 6)} ${digitsOnly.substring(6, digitsOnly.length.clamp(0, 8))}';
  }

  String _formatVariable(String digitsOnly, int prefixLength, int maxLength) {
    // Format: XXXX XXXXXXXX (variable length)
    if (digitsOnly.isEmpty) return '';
    if (digitsOnly.length < prefixLength + 1) return digitsOnly;
    return '${digitsOnly.substring(0, prefixLength)} ${digitsOnly.substring(prefixLength, digitsOnly.length.clamp(0, maxLength))}';
  }
}
