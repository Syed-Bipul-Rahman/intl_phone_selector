// lib/main.dart
import 'package:flutter/material.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Selector Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PhoneSelectorDemo(),
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
