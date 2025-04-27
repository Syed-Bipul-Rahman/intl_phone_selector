import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'country.dart';
import 'countries_data.dart';
import 'phone_number_controller.dart';

class BasicPhoneInput extends StatefulWidget {
  final PhoneNumberController controller;
  final InputDecoration? decoration;
  final Function(Country)? onCountryChanged;
  final Function(String)? onNumberChanged;
  final Function(bool)? onValidationChanged;
  final bool showFlag;
  final bool showCountryCode;
  final Widget Function(BuildContext, Country)? countryButtonBuilder;

  const BasicPhoneInput({
    super.key,
    required this.controller,
    this.decoration,
    this.onCountryChanged,
    this.onNumberChanged,
    this.onValidationChanged,
    this.showFlag = true,
    this.showCountryCode = true,
    this.countryButtonBuilder,
  });

  @override
  State<BasicPhoneInput> createState() => _BasicPhoneInputState();
}

class _BasicPhoneInputState extends State<BasicPhoneInput> {
  late final PhoneNumberController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(_onControllerChanged);
    _controller.numberController.addListener(_onTextChanged);
  }

  void _onControllerChanged() {
    setState(() {}); // Rebuild when controller changes
  }

  void _onTextChanged() {
    final isValid = _controller.isValid();
    widget.onNumberChanged?.call(_controller.numberController.text);
    widget.onValidationChanged?.call(isValid);

    // Auto-format as the user types
    _controller.formatPhoneNumber();
  }

  void _showCountriesDialog() async {
    final selectedCountry = await showDialog<Country>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Country'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: CountriesData.allCountries.length,
              itemBuilder: (context, index) {
                final country = CountriesData.allCountries[index];
                return ListTile(
                  leading: Text(country.flagEmoji),
                  title: Text(country.name),
                  subtitle: Text(country.dialCode),
                  onTap: () => Navigator.of(context).pop(country),
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedCountry != null) {
      _controller.setCountry(selectedCountry);
      widget.onCountryChanged?.call(selectedCountry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Country selection button
        if (widget.countryButtonBuilder != null)
          InkWell(
            onTap: _showCountriesDialog,
            child: widget.countryButtonBuilder!(
              context,
              _controller.selectedCountry,
            ),
          )
        else
          TextButton(
            onPressed: _showCountriesDialog,
            child: Row(
              children: [
                if (widget.showFlag)
                  Text(_controller.selectedCountry.flagEmoji),
                if (widget.showFlag && widget.showCountryCode)
                  const SizedBox(width: 4),
                if (widget.showCountryCode)
                  Text(_controller.selectedCountry.dialCode),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),

        // Phone number input field
        Expanded(
          child: TextField(
            controller: _controller.numberController,
            decoration:
                widget.decoration ??
                const InputDecoration(hintText: 'Phone number'),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\(\)]')),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.numberController.removeListener(_onTextChanged);
    super.dispose();
  }
}
