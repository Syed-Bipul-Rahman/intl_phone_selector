import 'package:flutter/material.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';
import 'examples/basic_example.dart';
import 'examples/intermediate_example.dart';
import 'examples/advanced_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'International Phone Selector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'System',
      ),
      home: const ExampleSelector(),
    );
  }
}

class ExampleSelector extends StatelessWidget {
  const ExampleSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade500,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'International Phone Selector',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Comprehensive examples for every skill level',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Examples
                Expanded(
                  child: ListView(
                    children: [
                      _buildExampleCard(
                        context,
                        title: '🚀 Basic Example',
                        subtitle: 'Perfect for beginners',
                        description: 'Simple phone input with basic validation and minimal setup',
                        color: Colors.green,
                        features: [
                          'BasicPhoneInput widget',
                          'Simple validation',
                          'Country selection',
                          'Clear documentation',
                        ],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BasicExample()),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildExampleCard(
                        context,
                        title: '⚡ Intermediate Example',
                        subtitle: 'For experienced developers',
                        description: 'Form integration, custom validation, and error handling',
                        color: Colors.orange,
                        features: [
                          'AdvancedPhoneInput widget',
                          'Form validation',
                          'Custom error handling',
                          'Real-time validation',
                        ],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const IntermediateExample()),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildExampleCard(
                        context,
                        title: '🏆 Advanced Example',
                        subtitle: 'For seasoned professionals',
                        description: 'Multiple phone inputs, business logic, and production patterns',
                        color: Colors.purple,
                        features: [
                          'Multiple phone controllers',
                          'Business validation logic',
                          'Advanced UI patterns',
                          'Production-ready code',
                        ],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdvancedExample()),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Original demo card
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.science, color: Colors.blue.shade600),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '🧪 Original Demo',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'The original demonstration showing basic and custom implementations side by side.',
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PhoneSelectorDemo(),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade600,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('View Original Demo'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required MaterialColor color,
    required List<String> features,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 6,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: color.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade400,
                    size: 16,
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: features.map((feature) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.shade200),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      color: color.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneSelectorDemo extends StatefulWidget {
  const PhoneSelectorDemo({Key? key}) : super(key: key);

  @override
  State<PhoneSelectorDemo> createState() => _PhoneSelectorDemoState();
}

class _PhoneSelectorDemoState extends State<PhoneSelectorDemo> {
  late PhoneNumberController _controller;
  bool _isValid = false;
  String _fullNumber = '';

  @override
  void initState() {
    super.initState();
    _controller = PhoneNumberController();
    _controller.addListener(_updatePhoneInfo);
  }

  void _updatePhoneInfo() {
    setState(() {
      _isValid = _controller.isValid();
      _fullNumber = _controller.completeNumber;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updatePhoneInfo);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Selector Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Default implementation
            Card(
              elevation: .5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Default Implementation:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BasicPhoneInput(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Custom implementation
            Card(
              elevation: .5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Custom Implementation:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCustomPhoneInput(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Phone information display
            Card(
              elevation: .5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Status:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Valid: '),
                        Icon(
                          _isValid ? Icons.check_circle : Icons.cancel,
                          color: _isValid ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('Complete number: $_fullNumber'),
                    SizedBox(height: 4),
                    Text('Country: ${_controller.selectedCountry.name}'),
                    SizedBox(height: 4),
                    Text(
                      'Country code: ${_controller.selectedCountry.dialCode}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              await _showCountryPicker();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    _controller.selectedCountry.flagEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _controller.selectedCountry.dialCode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_drop_down, size: 16),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Phone input field
          Expanded(
            child: TextField(
              controller: _controller.numberController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone number',
                hintStyle: TextStyle(color: Colors.grey),
                counterText: '',
              ),
              keyboardType: TextInputType.phone,
              onChanged: (_) {
                _controller.formatPhoneNumber();
              },
            ),
          ),

          // Clear button
          IconButton(
            icon: const Icon(Icons.clear, size: 18),
            onPressed: () {
              _controller.numberController.clear();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showCountryPicker() async {
    final selectedCountry = await showModalBottomSheet<Country>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return CountryPickerBottomSheet(
              controller: scrollController,
              onCountrySelected: (country) {
                Navigator.pop(context, country);
              },
              allCountries: CountriesData.allCountries,
              //CountriesData.allCountries,
            );
          },
        );
      },
    );

    if (selectedCountry != null) {
      _controller.setCountry(selectedCountry);
    }
  }
}

class CountryPickerBottomSheet extends StatefulWidget {
  final ScrollController controller;
  final Function(Country) onCountrySelected;
  final List<Country> allCountries;

  const CountryPickerBottomSheet({
    Key? key,
    required this.controller,
    required this.onCountrySelected,
    required this.allCountries,
  }) : super(key: key);

  @override
  _CountryPickerBottomSheetState createState() =>
      _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.allCountries;
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = widget.allCountries;
      } else {
        _filteredCountries =
            widget.allCountries
                .where(
                  (country) =>
                      country.name.toLowerCase().contains(query) ||
                      country.dialCode.contains(query) ||
                      country.code.toLowerCase().contains(query),
                )
                .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 16),
          height: 4,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                'Select Country',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Search field
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search country',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // Country list
        Expanded(
          child: ListView.builder(
            controller: widget.controller,
            itemCount: _filteredCountries.length,
            itemBuilder: (context, index) {
              final country = _filteredCountries[index];
              return ListTile(
                leading: Text(
                  country.flagEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(country.name),
                subtitle: Text(country.dialCode),
                onTap: () => widget.onCountrySelected(country),
              );
            },
          ),
        ),
      ],
    );
  }
}
