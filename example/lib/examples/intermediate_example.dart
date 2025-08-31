import 'package:flutter/material.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

/// Intermediate Example - For developers with some Flutter experience
/// This example shows advanced customization, form integration, and
/// custom validation with error handling.
class IntermediateExample extends StatefulWidget {
  const IntermediateExample({super.key});

  @override
  State<IntermediateExample> createState() => _IntermediateExampleState();
}

class _IntermediateExampleState extends State<IntermediateExample> {
  final _formKey = GlobalKey<FormState>();
  late PhoneNumberController _phoneController;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  
  bool _isPhoneValid = false;
  String? _phoneError;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _phoneController = PhoneNumberController(
      // Start with user's likely country (you could get this from locale)
      initialCountry: CountriesData.getCountryByCode('US'),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validatePhone() {
    if (_phoneController.isEmpty) {
      return 'Phone number is required';
    }
    if (!_phoneController.isValid()) {
      return 'Please enter a valid phone number for ${_phoneController.selectedCountry.name}';
    }
    return null;
  }

  Future<void> _submitForm() async {
    setState(() {
      _phoneError = _validatePhone();
    });

    if (_formKey.currentState!.validate() && _phoneError == null) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      if (mounted) {
        _showSuccessDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intermediate Example'),
        backgroundColor: Colors.green.shade100,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Header
            Card(
              elevation: 0,
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_add, color: Colors.green.shade700),
                        const SizedBox(width: 8),
                        Text(
                          '🚀 User Registration',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This example shows form integration, custom validation, and error handling.',
                      style: TextStyle(
                        color: Colors.green.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Phone Field with Advanced Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                AdvancedPhoneInput(
                  controller: _phoneController,
                  showValidationIcon: true,
                  borderRadius: 12,
                  errorText: _phoneError,
                  errorBorderColor: Colors.red.shade400,
                  focusedBorderColor: Colors.green.shade400,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, 
                    vertical: 16,
                  ),
                  onValidationChanged: (isValid) {
                    setState(() {
                      _isPhoneValid = isValid;
                      if (isValid) {
                        _phoneError = null;
                      }
                    });
                  },
                  onCountryChanged: (country) {
                    // Clear error when country changes
                    setState(() {
                      _phoneError = null;
                    });
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Country changed to ${country.name}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Live Validation Status
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📊 Live Validation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildValidationItem(
                      'Phone Number Format',
                      _isPhoneValid && !_phoneController.isEmpty,
                    ),
                    _buildValidationItem(
                      'Country Selected',
                      _phoneController.selectedCountry.code.isNotEmpty,
                    ),
                    _buildValidationItem(
                      'Number Not Empty',
                      !_phoneController.isEmpty,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text('Formatted: '),
                        Expanded(
                          child: Text(
                            _phoneController.formattedNumber.isEmpty 
                                ? 'Enter phone number to see formatting'
                                : _phoneController.formattedNumber,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Complete: '),
                        Expanded(
                          child: Text(
                            _phoneController.completeNumber == _phoneController.selectedCountry.dialCode
                                ? 'Enter phone number'
                                : _phoneController.completeNumber,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Submitting...'),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle),
                          SizedBox(width: 8),
                          Text('Create Account'),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Tips Card
            Card(
              color: Colors.blue.shade50,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          '💡 Pro Tips',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('• Use AdvancedPhoneInput for more customization'),
                    const Text('• Implement real-time validation for better UX'),
                    const Text('• Handle country changes for dynamic validation'),
                    const Text('• Show formatted number preview to users'),
                    const Text('• Use proper error states and loading indicators'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationItem(String label, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle_outline : Icons.highlight_off,
            color: isValid ? Colors.green : Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isValid ? Colors.green.shade700 : Colors.grey.shade600,
              fontWeight: isValid ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.celebration, color: Colors.green),
            SizedBox(width: 8),
            Text('🎉 Success!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Account created successfully!'),
            const SizedBox(height: 12),
            Text('Name: ${_nameController.text}'),
            Text('Email: ${_emailController.text}'),
            Text('Phone: ${_phoneController.completeNumber}'),
            Text('Country: ${_phoneController.selectedCountry.name}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Great!'),
          ),
        ],
      ),
    );
  }
}