# Changelog

All notable changes to the `intl_phone_selector` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-08-31

### 🎉 Major Update - Enhanced Package with Advanced Features

### Added
- **New `AdvancedPhoneInput` Widget**
  - Comprehensive customization options
  - Built-in validation icons
  - Popular countries section
  - Advanced search functionality
  - Custom styling options (border colors, radius, padding)
  - Error text display
  - Read-only mode support
  - Preferred countries list
  - Custom builders for country button and validation icon

- **Enhanced `PhoneNumberController`**
  - New `formattedNumber` getter for display purposes
  - `clearNumber()` method for programmatic clearing
  - `setPhoneNumber()` method for setting numbers programmatically
  - `isEmpty` getter for checking empty state
  - Improved error handling with fallback mechanisms
  - Better cursor position management during formatting

- **Enhanced `CountriesData` Utility Class**
  - `searchCountries()` method for flexible country search
  - `getPopularCountries()` method for common countries
  - Enhanced error handling in all lookup methods
  - Fallback mechanisms for invalid country codes
  - Support for both country codes and dial codes in search

- **Comprehensive Example Applications**
  - **Basic Example**: Perfect for beginners with step-by-step walkthrough
  - **Intermediate Example**: Form integration and advanced validation
  - **Advanced Example**: Multiple controllers, business logic, production patterns
  - Enhanced main example with beautiful UI and example selector

- **Performance Improvements**
  - Debounced validation to prevent unresponsiveness (200-300ms delay)
  - Optimized country search with multiple criteria
  - Better memory management with proper disposal
  - Efficient rendering with conditional widget building

### Fixed
- **Unresponsiveness Issues**
  - Fixed lag in basic example due to excessive formatting calls
  - Added debounced validation to prevent UI blocking
  - Improved cursor positioning during text formatting
  - Better handling of rapid text input changes

- **Error Handling**
  - Added comprehensive try-catch blocks throughout codebase
  - Fallback country selection when data is invalid
  - Graceful handling of formatting errors
  - Better validation state management

- **Validation Improvements**
  - Fixed edge cases in country-specific validation
  - Better handling of leading zeros in phone numbers
  - Enhanced international number validation (max 15 digits)
  - Added India and Israel back to countries list

### Changed
- **Breaking Changes**: None (fully backward compatible)
- Updated package version from 0.0.2 to 0.1.0
- Enhanced package description for better discoverability
- Improved README with comprehensive documentation
- Updated example app with multiple demonstration levels

### Documentation
- Complete API reference with usage examples
- Troubleshooting guide for common issues
- Performance optimization tips
- Contributing guidelines for developers
- Added comprehensive changelog documentation

## [0.0.2] - 2025-04-28
- Fix minor changes to improve `PhoneNumberFormatter`
- Improved documentation.

## [0.0.1] - 2025-04-27

### Initial Release

- **Features**:
    - Added `IntlPhoneSelector` widget for selecting international phone numbers with country code support.
    - Supports a list of countries with customizable country flags and dial codes.
    - Highly customizable with options for styling, country filtering, and UI adjustments.
    - Provides callback for handling phone number changes.
    - Includes validation for phone number input (optional).

- **Documentation**:
    - Added `README.md` with installation and usage instructions.
    - Included an example app in the `example/` folder demonstrating basic usage.

- **License**:
    - Released under the MIT License.

- **Setup**:
    - Configured for publishing to pub.dev.
    - Added initial test suite for core functionality.
