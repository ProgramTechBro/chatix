import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

class AppPhoneField extends StatefulWidget {
  const AppPhoneField({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialCountryCode = 'US',
  });

  final String label;
  final ValueChanged<String> onChanged;
  final String initialCountryCode;

  @override
  State<AppPhoneField> createState() => _AppPhoneFieldState();
}

class _AppPhoneFieldState extends State<AppPhoneField> {
  int _maxLength = 15;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 6),
          child: Text(widget.label.toUpperCase(), style: textTheme.labelSmall),
        ),
        IntlPhoneField(
          initialCountryCode: widget.initialCountryCode,
          keyboardType: TextInputType.number,
          invalidMessage: 'Please enter a valid phone number',
          style: textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(hintText: '0' * _maxLength),
          inputFormatters: [LengthLimitingTextInputFormatter(_maxLength)],
          onCountryChanged: (country) =>
              setState(() => _maxLength = country.maxLength),
          onChanged: (phone) => widget.onChanged(phone.completeNumber),
        ),
      ],
    );
  }
}
