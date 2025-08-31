import 'package:flutter/material.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

/// Basic Example - Perfect for beginners
/// This example shows the simplest way to use the phone selector
/// with minimal configuration and basic validation.
class BasicExample extends StatefulWidget {
  const BasicExample({super.key});

  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
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
      appBar: AppBar(
        title: const Text('Basic Phone Input Example'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '📱 Basic Phone Input',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is the simplest way to add international phone input to your app.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),

            // Basic Phone Input
            BasicPhoneInput(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
              onValidationChanged: (isValid) {
                setState(() {
                  _isValid = isValid;
                });
              },
            ),

            const SizedBox(height: 24),

            // Phone Status Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phone Status:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStatusRow(
                      'Valid', 
                      _isValid, 
                      _isValid ? Icons.check_circle : Icons.cancel,
                      _isValid ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow('Country', _controller.selectedCountry.name),
                    const SizedBox(height: 8),
                    _buildInfoRow('Dial Code', _controller.selectedCountry.dialCode),
                    const SizedBox(height: 8),
                    _buildInfoRow('Complete Number', _controller.completeNumber),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Button
            ElevatedButton.icon(
              onPressed: _isValid ? () => _showSuccessDialog() : null,
              icon: const Icon(Icons.phone_callback),
              label: const Text('Continue'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Code snippet card
            Expanded(
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💡 Code Snippet:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const SingleChildScrollView(
                            child: Text(
                              '''// 1. Create a controller
final controller = PhoneNumberController();

// 2. Add the BasicPhoneInput widget
BasicPhoneInput(
  controller: controller,
  decoration: InputDecoration(
    labelText: 'Phone Number',
    border: OutlineInputBorder(),
  ),
  onValidationChanged: (isValid) {
    // Handle validation changes
  },
)

// 3. Access the phone data
String completeNumber = controller.completeNumber;
bool isValid = controller.isValid();
Country selectedCountry = controller.selectedCountry;''',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status, IconData icon, Color color) {
    return Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 4),
        Text(
          status ? 'Yes' : 'No',
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('✅ Valid Phone Number'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Country: ${_controller.selectedCountry.name}'),
            Text('Number: ${_controller.completeNumber}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}