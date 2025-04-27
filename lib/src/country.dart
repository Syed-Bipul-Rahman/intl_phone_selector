class Country {
  final String name;
  final String code;
  final String dialCode;
  final String flagEmoji;

  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flagEmoji,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'],
      code: map['code'],
      dialCode: map['dialCode'],
      flagEmoji: map['flagEmoji'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'dialCode': dialCode,
      'flagEmoji': flagEmoji,
    };
  }

  @override
  String toString() {
    return '$flagEmoji $dialCode ($name)';
  }
}
