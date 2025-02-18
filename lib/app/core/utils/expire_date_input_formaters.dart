
import 'package:flutter/services.dart';

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    // Remove any non-digit characters
    String digitsOnly = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Add a slash after the first two digits (month)
    if (digitsOnly.length > 2) {
      digitsOnly = '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2)}';
    }

    // Limit to 5 characters (MM/YY)
    if (digitsOnly.length > 5) {
      digitsOnly = digitsOnly.substring(0, 5);
    }

    // Return the formatted value
    return TextEditingValue(
      text: digitsOnly,
      selection: TextSelection.collapsed(offset: digitsOnly.length),
    );
  }
}