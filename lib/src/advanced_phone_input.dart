import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'country.dart';
import 'countries_data.dart';
import 'phone_number_controller.dart';

class AdvancedPhoneInput extends StatefulWidget {
  final PhoneNumberController controller;
  final InputDecoration? decoration;
  final Function(Country)? onCountryChanged;
  final Function(String)? onNumberChanged;
  final Function(bool)? onValidationChanged;
  final bool showFlag;
  final bool showCountryCode;
  final bool showCountryName;
  final bool enableSearch;
  final bool showValidationIcon;
  final bool readOnly;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Widget Function(BuildContext, Country)? countryButtonBuilder;
  final Widget Function(BuildContext, bool, String?)? validationIconBuilder;
  final List<Country>? preferredCountries;
  final bool showPopularCountries;

  const AdvancedPhoneInput({
    super.key,
    required this.controller,
    this.decoration,
    this.onCountryChanged,
    this.onNumberChanged,
    this.onValidationChanged,
    this.showFlag = true,
    this.showCountryCode = true,
    this.showCountryName = false,
    this.enableSearch = true,
    this.showValidationIcon = true,
    this.readOnly = false,
    this.hintText,
    this.labelText,
    this.errorText,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius = 8.0,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    this.textStyle,
    this.hintStyle,
    this.countryButtonBuilder,
    this.validationIconBuilder,
    this.preferredCountries,
    this.showPopularCountries = false,
  });

  @override
  State<AdvancedPhoneInput> createState() => _AdvancedPhoneInputState();
}

class _AdvancedPhoneInputState extends State<AdvancedPhoneInput> {
  late final PhoneNumberController _controller;
  Timer? _debounceTimer;
  bool _isValidating = false;
  bool _isValid = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(_onControllerChanged);
    _controller.numberController.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
    _isValid = _controller.isValid();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onTextChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      if (mounted && !_isValidating) {
        _isValidating = true;
        
        try {
          final isValid = _controller.isValid();
          _isValid = isValid;
          widget.onNumberChanged?.call(_controller.numberController.text);
          widget.onValidationChanged?.call(isValid);

          _controller.formatPhoneNumber();
        } catch (e) {
          debugPrint('Phone validation error: $e');
        } finally {
          _isValidating = false;
          if (mounted) setState(() {});
        }
      }
    });
  }

  void _showCountriesBottomSheet() async {
    final selectedCountry = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CountryPickerBottomSheet(
        countries: widget.preferredCountries ?? CountriesData.allCountries,
        enableSearch: widget.enableSearch,
        showPopularCountries: widget.showPopularCountries,
        onCountrySelected: (country) {
          Navigator.pop(context, country);
        },
      ),
    );

    if (selectedCountry != null) {
      _controller.setCountry(selectedCountry);
      widget.onCountryChanged?.call(selectedCountry);
    }
  }

  Color _getBorderColor() {
    if (widget.errorText != null) {
      return widget.errorBorderColor ?? Colors.red;
    }
    if (_focusNode.hasFocus) {
      return widget.focusedBorderColor ?? Theme.of(context).primaryColor;
    }
    return widget.borderColor ?? Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: _getBorderColor()),
      ),
      child: Row(
        children: [
          // Country selection button
          InkWell(
            onTap: widget.readOnly ? null : _showCountriesBottomSheet,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(widget.borderRadius),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(widget.borderRadius),
                ),
              ),
              child: widget.countryButtonBuilder?.call(context, _controller.selectedCountry) ??
                  _buildDefaultCountryButton(),
            ),
          ),

          // Divider
          Container(
            width: 1,
            height: 24,
            color: Colors.grey.shade300,
          ),

          // Phone number input field
          Expanded(
            child: TextField(
              controller: _controller.numberController,
              focusNode: _focusNode,
              readOnly: widget.readOnly,
              style: widget.textStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText ?? 'Phone number',
                hintStyle: widget.hintStyle,
                contentPadding: widget.contentPadding,
                errorText: widget.errorText,
                counterText: '',
                suffixIcon: widget.showValidationIcon 
                    ? widget.validationIconBuilder?.call(context, _isValid, widget.errorText) ??
                        _buildDefaultValidationIcon()
                    : null,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\(\)]')),
                LengthLimitingTextInputFormatter(20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCountryButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showFlag)
          Text(
            _controller.selectedCountry.flagEmoji,
            style: const TextStyle(fontSize: 20),
          ),
        if (widget.showFlag && (widget.showCountryCode || widget.showCountryName))
          const SizedBox(width: 8),
        if (widget.showCountryCode)
          Text(
            _controller.selectedCountry.dialCode,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        if (widget.showCountryName) ...[
          const SizedBox(width: 4),
          Text(
            _controller.selectedCountry.name,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(width: 4),
        Icon(
          Icons.arrow_drop_down,
          size: 16,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }

  Widget _buildDefaultValidationIcon() {
    if (_controller.isEmpty) return const SizedBox.shrink();
    
    return Icon(
      _isValid ? Icons.check_circle : Icons.error,
      color: _isValid ? Colors.green : Colors.red,
      size: 20,
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _focusNode.dispose();
    _controller.removeListener(_onControllerChanged);
    _controller.numberController.removeListener(_onTextChanged);
    super.dispose();
  }
}

class CountryPickerBottomSheet extends StatefulWidget {
  final List<Country> countries;
  final bool enableSearch;
  final bool showPopularCountries;
  final Function(Country) onCountrySelected;

  const CountryPickerBottomSheet({
    super.key,
    required this.countries,
    required this.onCountrySelected,
    this.enableSearch = true,
    this.showPopularCountries = false,
  });

  @override
  State<CountryPickerBottomSheet> createState() => _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();
  List<Country> _popularCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
    if (widget.showPopularCountries) {
      _popularCountries = CountriesData.getPopularCountries();
    }
    if (widget.enableSearch) {
      _searchController.addListener(_filterCountries);
    }
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = widget.countries;
      } else {
        _filteredCountries = CountriesData.searchCountries(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
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

          // Header and Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Text(
                  'Select Country',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (widget.enableSearch) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search countries...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Popular Countries Section
          if (widget.showPopularCountries && _searchController.text.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Countries',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _popularCountries.length,
                      itemBuilder: (context, index) {
                        final country = _popularCountries[index];
                        return GestureDetector(
                          onTap: () => widget.onCountrySelected(country),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(country.flagEmoji, style: const TextStyle(fontSize: 20)),
                                const SizedBox(height: 4),
                                Text(country.code, style: const TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],

          // Country List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Text(country.flagEmoji, style: const TextStyle(fontSize: 20)),
                  ),
                  title: Text(country.name),
                  subtitle: Text(country.dialCode),
                  onTap: () => widget.onCountrySelected(country),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}