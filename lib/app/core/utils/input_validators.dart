
import 'package:alalamia_spices/app/data/providers/translations.dart';

class InputValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return allTranslations.text("fieldRequired");
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      return allTranslations.text("invalidEmailFormat");
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    // You can add more complex password validation rules here, e.g.,
    // checking for uppercase, lowercase, numbers, and special characters.
    return null;
  }

  static String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return allTranslations.text("fieldRequired");
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)) {
      return 'Invalid phone number format';
    }
    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    // Basic Luhn algorithm check (you might want a more robust implementation)
    String cleanedValue = value.replaceAll(RegExp(r'\s+'), '');
    if (cleanedValue.length < 13 || cleanedValue.length > 19) {
      return 'Invalid card number length';
    }
    if (!isValidCardNumber(cleanedValue)) {
      return 'Invalid card number';
    }
    return null;
  }

  static bool isValidCardNumber(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }
    if (value.length < 3 || value.length > 4) {
      return 'Invalid CVV';
    }
    return null;
  }

  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }

    if (!RegExp(r'^(0[1-9]|1[0-2])\/[0-9]{2}$').hasMatch(value)){
      return 'Invalid expiry date format (MM/YY)';
    }

    List<String> parts = value.split('/');
    int month = int.parse(parts[0]);
    int year = int.parse(parts[1]);

    int currentYear = DateTime.now().year % 100; // Get last two digits
    int currentMonth = DateTime.now().month;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'Card has expired';
    }

    return null;
  }
}