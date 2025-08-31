import 'package:flutter/material.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

/// Advanced Example - For seasoned Flutter developers
/// This example demonstrates custom themes, advanced validation,
/// multiple phone inputs, business logic, and production-ready patterns.
class AdvancedExample extends StatefulWidget {
  const AdvancedExample({super.key});

  @override
  State<AdvancedExample> createState() => _AdvancedExampleState();
}

class _AdvancedExampleState extends State<AdvancedExample>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  
  // Multiple phone controllers for different purposes
  late PhoneNumberController _primaryController;
  late PhoneNumberController _secondaryController;
  late PhoneNumberController _businessController;
  
  // Form controllers
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  
  // State management
  PhoneType _selectedPhoneType = PhoneType.mobile;
  bool _enableTwoFactor = false;
  bool _enableBusinessHours = false;
  List<Country> _preferredCountries = [];
  
  // Validation state
  final Map<String, String?> _errors = {};
  bool _showAdvancedValidation = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize controllers with default country (will be updated in didChangeDependencies)
    _primaryController = PhoneNumberController(
      initialCountry: CountriesData.getCountryByCode('US'),
    );
    _secondaryController = PhoneNumberController(
      initialCountry: CountriesData.getCountryByCode('US'),
    );
    _businessController = PhoneNumberController(
      initialCountry: CountriesData.getCountryByCode('US'),
    );
    
    _setupPreferredCountries();
    _setupControllerListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update controllers with user's locale-based country
    final userCountry = _getUserCountryFromLocale();
    _primaryController.setCountry(userCountry);
    _secondaryController.setCountry(userCountry);
    _businessController.setCountry(userCountry);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _primaryController.dispose();
    _secondaryController.dispose();
    _businessController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  Country _getUserCountryFromLocale() {
    // In a real app, you'd get this from device locale or user preferences
    final locale = Localizations.of(context, Localizations)?.locale.countryCode ?? 'US';
    return CountriesData.getCountryByCode(locale);
  }

  void _setupPreferredCountries() {
    // Simulate user's preferred countries based on history/contacts
    _preferredCountries = [
      CountriesData.getCountryByCode('US'),
      CountriesData.getCountryByCode('CA'),
      CountriesData.getCountryByCode('GB'),
      CountriesData.getCountryByCode('AU'),
      CountriesData.getCountryByCode('IN'),
    ];
  }

  void _setupControllerListeners() {
    _primaryController.addListener(() => _validatePhoneField('primary'));
    _secondaryController.addListener(() => _validatePhoneField('secondary'));
    _businessController.addListener(() => _validatePhoneField('business'));
  }

  void _validatePhoneField(String field) {
    setState(() {
      switch (field) {
        case 'primary':
          _errors[field] = _validatePhone(_primaryController, isRequired: true);
          break;
        case 'secondary':
          _errors[field] = _validatePhone(_secondaryController, isRequired: false);
          break;
        case 'business':
          _errors[field] = _validatePhone(_businessController, 
            isRequired: _enableBusinessHours,
            businessValidation: true,
          );
          break;
      }
    });
  }

  String? _validatePhone(PhoneNumberController controller, {
    bool isRequired = false,
    bool businessValidation = false,
  }) {
    if (!isRequired && controller.isEmpty) return null;
    
    if (isRequired && controller.isEmpty) {
      return 'This phone number is required';
    }
    
    if (!controller.isValid()) {
      return 'Invalid phone number for ${controller.selectedCountry.name}';
    }
    
    // Business-specific validation
    if (businessValidation) {
      final number = controller.numberController.text;
      if (number.startsWith('800') || number.startsWith('888')) {
        return 'Toll-free numbers are not allowed for business contacts';
      }
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Phone Integration'),
        backgroundColor: Colors.purple.shade100,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Personal'),
            Tab(icon: Icon(Icons.business), text: 'Business'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalTab(),
          _buildBusinessTab(),
          _buildSettingsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _validateAndSubmit,
        icon: const Icon(Icons.save),
        label: const Text('Save Profile'),
        backgroundColor: Colors.purple.shade600,
      ),
    );
  }

  Widget _buildPersonalTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          title: '📱 Primary Phone',
          subtitle: 'Your main contact number',
          child: Column(
            children: [
              _buildAdvancedPhoneInput(
                controller: _primaryController,
                label: 'Primary Phone Number',
                errorText: _errors['primary'],
                prefixIcon: Icons.smartphone,
                isRequired: true,
              ),
              const SizedBox(height: 16),
              
              // Phone type selector
              Row(
                children: [
                  const Text('Type: ', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SegmentedButton<PhoneType>(
                      segments: const [
                        ButtonSegment(
                          value: PhoneType.mobile,
                          label: Text('Mobile'),
                          icon: Icon(Icons.smartphone),
                        ),
                        ButtonSegment(
                          value: PhoneType.landline,
                          label: Text('Landline'),
                          icon: Icon(Icons.phone),
                        ),
                      ],
                      selected: {_selectedPhoneType},
                      onSelectionChanged: (Set<PhoneType> selection) {
                        setState(() {
                          _selectedPhoneType = selection.first;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: '📞 Secondary Phone',
          subtitle: 'Optional backup number',
          child: _buildAdvancedPhoneInput(
            controller: _secondaryController,
            label: 'Secondary Phone Number',
            errorText: _errors['secondary'],
            prefixIcon: Icons.phone_android,
            isRequired: false,
          ),
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: '🔒 Two-Factor Authentication',
          subtitle: 'Enhanced security settings',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Enable 2FA via SMS'),
                subtitle: const Text('Receive verification codes on your primary phone'),
                value: _enableTwoFactor,
                onChanged: (value) {
                  setState(() {
                    _enableTwoFactor = value;
                  });
                },
                secondary: const Icon(Icons.security),
              ),
              if (_enableTwoFactor) ...[
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('SMS charges may apply'),
                  subtitle: Text(
                    'Codes will be sent to ${_primaryController.completeNumber}',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          title: '🏢 Business Information',
          subtitle: 'Company and professional details',
          child: Column(
            children: [
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  prefixIcon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position/Title',
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: '☎️ Business Phone',
          subtitle: 'Professional contact number',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Enable Business Hours'),
                subtitle: const Text('Only receive calls during work hours'),
                value: _enableBusinessHours,
                onChanged: (value) {
                  setState(() {
                    _enableBusinessHours = value;
                  });
                },
                secondary: const Icon(Icons.schedule),
              ),
              if (_enableBusinessHours) ...[
                const SizedBox(height: 16),
                _buildAdvancedPhoneInput(
                  controller: _businessController,
                  label: 'Business Phone Number',
                  errorText: _errors['business'],
                  prefixIcon: Icons.business_center,
                  isRequired: true,
                ),
              ],
            ],
          ),
        ),

        if (_enableBusinessHours) ...[
          const SizedBox(height: 16),
          _buildSectionCard(
            title: '🕒 Business Hours',
            subtitle: 'Configure availability',
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: const Text('Monday - Friday'),
                  subtitle: const Text('9:00 AM - 5:00 PM'),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Business hours configuration')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('Timezone: ${_businessController.selectedCountry.name}'),
                  subtitle: const Text('Based on business phone country'),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          title: '🌍 Preferred Countries',
          subtitle: 'Countries you frequently use',
          child: Column(
            children: [
              const Text(
                'These countries will appear at the top of the selection list',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _preferredCountries.length,
                  itemBuilder: (context, index) {
                    final country = _preferredCountries[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: Chip(
                        avatar: Text(country.flagEmoji),
                        label: Text(country.code),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _preferredCountries.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: '🔧 Validation Settings',
          subtitle: 'Advanced validation options',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Show Advanced Validation'),
                subtitle: const Text('Display detailed validation messages'),
                value: _showAdvancedValidation,
                onChanged: (value) {
                  setState(() {
                    _showAdvancedValidation = value;
                  });
                },
                secondary: const Icon(Icons.rule),
              ),
              if (_showAdvancedValidation)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Advanced Validation Rules:', 
                        style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('• Real-time format validation'),
                      Text('• Country-specific number length checks'),
                      Text('• Business number validation'),
                      Text('• Duplicate number detection'),
                      Text('• Regional carrier validation'),
                    ],
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _buildSectionCard(
          title: '📊 Phone Number Analysis',
          subtitle: 'Current configuration overview',
          child: _buildPhoneAnalysis(),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
            )),
            Text(subtitle, style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            )),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedPhoneInput({
    required PhoneNumberController controller,
    required String label,
    required IconData prefixIcon,
    String? errorText,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(prefixIcon, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            if (isRequired)
              const Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        AdvancedPhoneInput(
          controller: controller,
          showValidationIcon: true,
          showPopularCountries: true,
          preferredCountries: _preferredCountries,
          borderRadius: 12,
          errorText: errorText,
          errorBorderColor: Colors.red.shade400,
          focusedBorderColor: Colors.purple.shade400,
          onValidationChanged: (isValid) {
            // Handled by controller listeners
          },
          validationIconBuilder: (context, isValid, error) {
            if (controller.isEmpty) return const SizedBox.shrink();
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isValid ? Icons.check_circle : Icons.error,
                color: isValid ? Colors.green : Colors.red,
                size: 20,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPhoneAnalysis() {
    return Column(
      children: [
        _buildAnalysisRow('Primary Phone', _primaryController),
        if (!_secondaryController.isEmpty)
          _buildAnalysisRow('Secondary Phone', _secondaryController),
        if (_enableBusinessHours && !_businessController.isEmpty)
          _buildAnalysisRow('Business Phone', _businessController),
        
        const Divider(),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAnalysisChip(
              'Total Numbers', 
              _getActivePhoneCount().toString(),
              Icons.phone,
            ),
            _buildAnalysisChip(
              'Countries', 
              _getUniqueCountryCount().toString(),
              Icons.public,
            ),
            _buildAnalysisChip(
              'Valid', 
              _getValidPhoneCount().toString(),
              Icons.check_circle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalysisRow(String label, PhoneNumberController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              controller.isEmpty ? 'Not set' : controller.completeNumber,
              style: TextStyle(
                fontFamily: 'monospace',
                color: controller.isEmpty ? Colors.grey : Colors.blue.shade700,
              ),
            ),
          ),
          Icon(
            controller.isEmpty 
                ? Icons.remove_circle_outline
                : controller.isValid() 
                    ? Icons.check_circle 
                    : Icons.error,
            color: controller.isEmpty 
                ? Colors.grey
                : controller.isValid() 
                    ? Colors.green 
                    : Colors.red,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisChip(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.purple.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  int _getActivePhoneCount() {
    int count = 0;
    if (!_primaryController.isEmpty) count++;
    if (!_secondaryController.isEmpty) count++;
    if (_enableBusinessHours && !_businessController.isEmpty) count++;
    return count;
  }

  int _getUniqueCountryCount() {
    final countries = <String>{};
    if (!_primaryController.isEmpty) {
      countries.add(_primaryController.selectedCountry.code);
    }
    if (!_secondaryController.isEmpty) {
      countries.add(_secondaryController.selectedCountry.code);
    }
    if (_enableBusinessHours && !_businessController.isEmpty) {
      countries.add(_businessController.selectedCountry.code);
    }
    return countries.length;
  }

  int _getValidPhoneCount() {
    int count = 0;
    if (!_primaryController.isEmpty && _primaryController.isValid()) count++;
    if (!_secondaryController.isEmpty && _secondaryController.isValid()) count++;
    if (_enableBusinessHours && !_businessController.isEmpty && _businessController.isValid()) count++;
    return count;
  }

  Future<void> _validateAndSubmit() async {
    _validatePhoneField('primary');
    _validatePhoneField('secondary');
    _validatePhoneField('business');

    final hasErrors = _errors.values.any((error) => error != null);
    
    if (!hasErrors) {
      // Show success and simulate save
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Profile saved successfully!'),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // In a real app, you'd save to backend/database here
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        _showCompletionDialog();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text('Please fix validation errors'),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.stars, color: Colors.purple),
            SizedBox(width: 8),
            Text('🎉 Advanced Setup Complete!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your advanced phone configuration has been saved:'),
            const SizedBox(height: 16),
            Text('📱 Primary: ${_primaryController.completeNumber}'),
            if (!_secondaryController.isEmpty)
              Text('📞 Secondary: ${_secondaryController.completeNumber}'),
            if (_enableBusinessHours && !_businessController.isEmpty)
              Text('🏢 Business: ${_businessController.completeNumber}'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Features Enabled:', 
                    style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('• Two-Factor Auth: ${_enableTwoFactor ? "Yes" : "No"}'),
                  Text('• Business Hours: ${_enableBusinessHours ? "Yes" : "No"}'),
                  Text('• Advanced Validation: ${_showAdvancedValidation ? "Yes" : "No"}'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Awesome!'),
          ),
        ],
      ),
    );
  }
}

enum PhoneType { mobile, landline }