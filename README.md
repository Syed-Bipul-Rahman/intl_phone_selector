# intl_phone_selector

A highly customizable international phone number selector for Flutter applications. This package provides both simple and advanced phone input widgets with comprehensive validation, error handling, and production-ready features.

[![Pub Version](https://img.shields.io/pub/v/intl_phone_selector.svg)](https://pub.dev/packages/intl_phone_selector)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

### 🎯 Core Features
- 🌐 **International Support** - 200+ countries with accurate dial codes and flags
- 🎨 **Highly Customizable** - Complete UI control with custom widgets
- ✅ **Smart Validation** - Country-specific validation with real-time feedback
- 📱 **Auto-formatting** - Automatic number formatting based on country standards
- 🔍 **Smart Search** - Country search with multiple criteria (name, code, dial code)
- 🚀 **Performance Optimized** - Debounced validation and efficient rendering
- 🛡️ **Error Resilient** - Comprehensive error handling and fallbacks

### 🔧 Advanced Features
- 📊 **Multiple Input Styles** - BasicPhoneInput and AdvancedPhoneInput widgets  
- 🎯 **Preferred Countries** - Configurable popular/recent countries
- 🔄 **Real-time Updates** - Live validation status and formatting preview
- 📈 **Business Logic Ready** - Production patterns and validation rules
- 🎨 **Theme Support** - Full Material Design 3 integration
- 🛠️ **Developer Friendly** - Comprehensive examples and documentation

## Screenshots

<div style="display: flex; gap: 20px;">
  <img src="screenshots/basic_implementation.png" alt="Basic Implementation" style="width: 250px; height: auto;">
  <img src="screenshots/country_picker.png" alt="Country Picker" style="width: 250px; height: auto;">
  <img src="screenshots/custom_implementation.png" alt="Custom Implementation" style="width: 250px; height: auto;">
</div>

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  intl_phone_selector: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### 1️⃣ Basic Implementation (For Beginners)

```dart
import 'package:flutter/material.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

class PhoneInputExample extends StatefulWidget {
  @override
  _PhoneInputExampleState createState() => _PhoneInputExampleState();
}

class _PhoneInputExampleState extends State<PhoneInputExample> {
  late PhoneNumberController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = PhoneNumberController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BasicPhoneInput(
              controller: _controller,
              onValidationChanged: (isValid) {
                setState(() {
                  _isValid = isValid;
                });
              },
              decoration: InputDecoration(
                hintText: "Enter phone number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Valid: $_isValid'),
            SizedBox(height: 8),
            Text('Number: ${_controller.completeNumber}'),
          ],
        ),
      ),
    );
  }
}
```

### 2️⃣ Advanced Implementation (For Experienced Developers)

Use the `AdvancedPhoneInput` widget for more features and customization options:

```dart
import 'package:flutter/material.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

class AdvancedPhoneExample extends StatefulWidget {
  @override
  _AdvancedPhoneExampleState createState() => _AdvancedPhoneExampleState();
}

class _AdvancedPhoneExampleState extends State<AdvancedPhoneExample> {
  late PhoneNumberController _controller;
  String? _errorText;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = PhoneNumberController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Advanced Phone Input')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AdvancedPhoneInput(
              controller: _controller,
              showValidationIcon: true,
              showPopularCountries: true,
              enableSearch: true,
              borderRadius: 12,
              errorText: _errorText,
              hintText: 'Enter your phone number',
              onValidationChanged: (isValid) {
                setState(() {
                  _isValid = isValid;
                  _errorText = isValid ? null : 'Invalid phone number';
                });
              },
              onCountryChanged: (country) {
                print('Selected: ${country.name}');
              },
            ),
            
            SizedBox(height: 16),
            
            Text('Status: ${_isValid ? "Valid" : "Invalid"}'),
            Text('Number: ${_controller.completeNumber}'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 3️⃣ Custom Implementation (Complete Control)

For complete UI control, you can build custom interfaces while using the core functionality:

```dart
Widget _buildCustomPhoneInput() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey.shade100,
      border: Border.all(color: Colors.grey.shade400),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        // Custom country selector
        InkWell(
          onTap: () async {
            final country = await showYourCustomCountryPicker(context);
            if (country != null) {
              _controller.setCountry(country);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(_controller.selectedCountry.flagEmoji),
                SizedBox(width: 4),
                Text(_controller.selectedCountry.dialCode),
                Icon(Icons.arrow_drop_down, size: 16),
              ],
            ),
          ),
        ),

        SizedBox(width: 12),

        // Custom phone field
        Expanded(
          child: TextField(
            controller: _controller.numberController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Phone number',
            ),
            keyboardType: TextInputType.phone,
            onChanged: (_) {
              _controller.formatPhoneNumber();
            },
          ),
        ),
      ],
    ),
  );
}
```

## 📚 API Reference

### PhoneNumberController

The core controller class that manages phone number input, country selection, and validation.

#### Properties
```dart
final controller = PhoneNumberController();

// Core properties
String completeNumber;           // Full number with country code
String formattedNumber;          // Formatted display number
Country selectedCountry;         // Currently selected country
TextEditingController numberController; // Access to text input
bool isEmpty;                    // Check if input is empty

// Methods
bool isValid();                  // Validate current number
void setCountry(Country country); // Change country
void setPhoneNumber(String number); // Set number programmatically
void clearNumber();              // Clear input
void formatPhoneNumber();        // Apply formatting
```

#### Usage Examples
```dart
// Initialize with specific country
final controller = PhoneNumberController(
  initialCountry: CountriesData.getCountryByCode('GB'),
);

// Listen to changes
controller.addListener(() {
  print('Phone changed: ${controller.completeNumber}');
  print('Is valid: ${controller.isValid()}');
});

// Clean up
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

### Country

A model class that represents country data with dial code and flag.

```dart

Country myCountry = Country(
  name: 'United States',
  code: 'US',
  dialCode: '+1',
  flagEmoji: '🇺🇸',
);
```

### BasicPhoneInput

A ready-to-use phone input widget that provides basic functionality with simple setup.

#### Parameters
```dart
BasicPhoneInput(
  controller: controller,                    // Required: PhoneNumberController
  decoration: InputDecoration(...),          // Optional: Input decoration
  onValidationChanged: (bool isValid) {},   // Optional: Validation callback
  onNumberChanged: (String number) {},      // Optional: Number change callback  
  onCountryChanged: (Country country) {},   // Optional: Country change callback
  showFlag: true,                           // Optional: Show country flag
  showCountryCode: true,                    // Optional: Show dial code
  countryButtonBuilder: (context, country) => CustomWidget(), // Optional: Custom country button
)
```

### AdvancedPhoneInput

A feature-rich phone input widget with advanced customization and validation options.

#### Parameters
```dart
AdvancedPhoneInput(
  controller: controller,                    // Required: PhoneNumberController
  
  // Display Options
  showFlag: true,                           // Show country flag
  showCountryCode: true,                    // Show dial code  
  showCountryName: false,                   // Show country name
  showValidationIcon: true,                 // Show validation status icon
  showPopularCountries: false,              // Show popular countries section
  
  // Functionality
  enableSearch: true,                       // Enable country search
  readOnly: false,                          // Make input read-only
  preferredCountries: [countries],          // List of preferred countries
  
  // Styling
  borderRadius: 8.0,                        // Border radius
  borderColor: Colors.grey,                 // Border color
  focusedBorderColor: Colors.blue,          // Focused border color
  errorBorderColor: Colors.red,             // Error border color
  contentPadding: EdgeInsets.all(12),       // Input padding
  
  // Text & Labels
  hintText: 'Phone number',                 // Placeholder text
  labelText: 'Phone',                       // Label text
  errorText: 'Invalid number',              // Error message
  textStyle: TextStyle(...),                // Input text style
  hintStyle: TextStyle(...),                // Hint text style
  
  // Callbacks
  onValidationChanged: (bool isValid) {},   // Validation status changed
  onCountryChanged: (Country country) {},   // Country selection changed
  onNumberChanged: (String number) {},      // Phone number changed
  
  // Custom Builders
  countryButtonBuilder: (context, country) => Widget, // Custom country selector
  validationIconBuilder: (context, isValid, error) => Widget, // Custom validation icon
)
```

### CountriesData

A utility class containing country data and helper methods with enhanced search capabilities.

#### Methods
```dart
// Core Data Access
List<Country> allCountries = CountriesData.allCountries; // 200+ countries

// Search Methods  
Country getCountryByCode(String code);           // Find by country code (e.g., 'US')
Country getCountryByDialCode(String dialCode);   // Find by dial code (e.g., '+1')
List<Country> searchCountries(String query);     // Search by name, code, or dial code

// Utility Methods
List<Country> getPopularCountries();             // Get commonly used countries
```

#### Usage Examples
```dart
// Basic lookups
Country us = CountriesData.getCountryByCode('US');
Country uk = CountriesData.getCountryByDialCode('+44');

// Search functionality
List<Country> results = CountriesData.searchCountries('united');
// Returns: [United States, United Kingdom, United Arab Emirates]

// Popular countries for quick access
List<Country> popular = CountriesData.getPopularCountries();
// Returns: [US, UK, CA, AU, DE, FR, IN, CN, JP, BR]

// Safe operations - all methods include error handling
Country fallback = CountriesData.getCountryByCode('INVALID'); // Returns US as fallback
```

## Customization Options

### Phone Number Formatting

The package automatically formats phone numbers based on the selected country's standards. You can
customize this behavior by modifying the `PhoneNumberFormatter` class:

```dart
class MyCustomFormatter extends PhoneNumberFormatter {
  @override
  String format(String text, String countryCode) {
    // Your custom formatting logic
    return formattedText;
  }
}
```

### Country Picker

You can implement your own country picker UI while still using the package's data:

```dart
Future<void> _showCountryPicker() async {
  final selectedCountry = await showModalBottomSheet<Country>(
    context: context,
    builder: (context) {
      return YourCustomCountryPicker(
        countries: CountriesData.allCountries,
        onCountrySelected: (country) {
          Navigator.pop(context, country);
        },
      );
    },
  );

  if (selectedCountry != null) {
    _controller.setCountry(selectedCountry);
  }
}
```

## Adding Your Own Countries

You can extend the country data with your own countries:

```dart
// Add your custom countries
List<Country> myCustomCountries = [
  ...CountriesData.allCountries,
  Country(
    name: 'My Country',
    code: 'MC',
    dialCode: '+999',
    flagEmoji: '🏳️',
  ),
];
```

## 🎯 Examples & Tutorials

The package includes comprehensive examples for every skill level:

### 📚 Interactive Examples
Run the example app to see all implementations in action:

```bash
cd example
flutter run
```

The example app includes:

#### 🚀 **Basic Example** - Perfect for Beginners
- Simple `BasicPhoneInput` implementation
- Basic validation and error handling  
- Step-by-step code walkthrough
- Clear documentation and tips

#### ⚡ **Intermediate Example** - For Experienced Developers  
- `AdvancedPhoneInput` with custom styling
- Form integration and validation
- Real-time validation feedback
- Error handling patterns

#### 🏆 **Advanced Example** - For Seasoned Professionals
- Multiple phone controllers
- Business logic validation
- Production-ready patterns
- Complex UI flows with tabs and settings

### 🔧 Common Use Cases

#### Form Integration
```dart
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late PhoneNumberController _phoneController;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    _phoneController = PhoneNumberController();
  }

  String? _validatePhone() {
    if (_phoneController.isEmpty) {
      return 'Phone number is required';
    }
    if (!_phoneController.isValid()) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Other form fields...
          
          AdvancedPhoneInput(
            controller: _phoneController,
            errorText: _phoneError,
            onValidationChanged: (isValid) {
              setState(() {
                _phoneError = isValid ? null : 'Invalid phone number';
              });
            },
          ),
          
          ElevatedButton(
            onPressed: () {
              setState(() {
                _phoneError = _validatePhone();
              });
              
              if (_formKey.currentState!.validate() && _phoneError == null) {
                // Submit form
                _submitForm();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Use _phoneController.completeNumber for submission
    print('Submitting: ${_phoneController.completeNumber}');
  }
}
```

#### Custom Country Selection
```dart
AdvancedPhoneInput(
  controller: _controller,
  preferredCountries: [
    CountriesData.getCountryByCode('US'),
    CountriesData.getCountryByCode('CA'), 
    CountriesData.getCountryByCode('GB'),
  ],
  showPopularCountries: true,
  countryButtonBuilder: (context, country) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(country.flagEmoji, style: TextStyle(fontSize: 20)),
          SizedBox(width: 8),
          Text(country.dialCode, style: TextStyle(fontWeight: FontWeight.bold)),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  },
)
```

For complete examples with detailed explanations, see the [example app](example/lib/main.dart).

## 🐛 Troubleshooting

### Common Issues

#### Phone number not formatting correctly
```dart
// Ensure you're calling formatPhoneNumber after setting the text
controller.setPhoneNumber('1234567890');
controller.formatPhoneNumber(); // This will format based on country
```

#### Validation not working
```dart
// Make sure to check both isEmpty and isValid
if (controller.isEmpty) {
  print('Please enter a phone number');
} else if (!controller.isValid()) {
  print('Please enter a valid phone number for ${controller.selectedCountry.name}');
}
```

#### Performance issues with frequent updates
```dart
// The package includes debouncing, but you can also debounce manually
Timer? _debounceTimer;

void _onPhoneChanged() {
  _debounceTimer?.cancel();
  _debounceTimer = Timer(Duration(milliseconds: 300), () {
    // Your validation logic here
  });
}
```

### Performance Tips
- ✅ Use `AdvancedPhoneInput` for better performance with large country lists
- ✅ Set `preferredCountries` to reduce search time
- ✅ Enable `showPopularCountries` for faster country selection
- ✅ Use proper disposal of controllers to prevent memory leaks

## 📋 Changelog

### Version 0.1.0
- 🎉 **Major Update**: Added `AdvancedPhoneInput` widget
- ✨ **New Features**: 
  - Enhanced error handling and fallbacks
  - Popular countries support
  - Advanced search functionality
  - Real-time validation with debouncing
  - Custom validation icon builders
  - Preferred countries list
- 🐛 **Bug Fixes**: 
  - Fixed unresponsiveness issues in basic example
  - Improved cursor positioning during formatting
  - Better error handling for invalid country codes
- 🚀 **Performance**: Debounced validation for better responsiveness
- 📚 **Documentation**: Added comprehensive examples for all skill levels

### Version 0.0.2
- Basic phone input functionality
- Country selection and validation
- Phone number formatting

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Report Issues**: Found a bug? Open an issue with detailed reproduction steps
2. **Feature Requests**: Have an idea? Create a feature request issue
3. **Pull Requests**: Want to contribute code? Fork the repo and create a PR
4. **Documentation**: Help improve examples and documentation
5. **Testing**: Test the package with different countries and edge cases

### Development Setup
```bash
git clone https://github.com/Syed-Bipul-Rahman/intl_phone_selector.git
cd intl_phone_selector
flutter pub get
cd example
flutter run
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Country data sourced from international telecommunications standards
- Flag emojis provided by Unicode Consortium
- Special thanks to the Flutter community for feedback and suggestions
