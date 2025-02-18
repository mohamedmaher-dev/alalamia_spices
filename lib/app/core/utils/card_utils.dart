
import 'package:flutter/services.dart';
import '../../data/providers/translations.dart';
import 'card_number_input_formater.dart';
import 'expire_date_input_formaters.dart';

class CardUtils{
  CardUtils._();

  /// card number
  static List<TextInputFormatter> cardInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(19),
    CardNumberInputFormatter(),
  ];
  static String? cardValidator(String? value) {
    if (value == null || value.isEmpty) {
      return allTranslations.text("fieldRequired");
    }
    if (value.length <= 16) {
      return allTranslations.text("cardFieldsNumber");
    }
    return null;
  }


  /// cvv
  static List<TextInputFormatter> cvvFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(4),
  ];
  static String? validateCVV(String value) {
    if (value.isEmpty) {
      return allTranslations.text("fieldRequired");
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }


  /// date
  static List<TextInputFormatter> dateFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    ExpiryDateInputFormatter(),
  ];
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return allTranslations.text("fieldRequired");;
    }

    // Validate length (must be 5 characters: MM/YY)
    if (value.length != 5 || !value.contains('/')) {
      return allTranslations.text("enterValidExpireDate");
    }

    // Validate month and year
    final parts = value.split('/');
    if (parts.length == 2) {
      final month = int.tryParse(parts[0]) ?? 0;
      final year = int.tryParse(parts[1]) ?? 0;

      if (month < 1 || month > 12) {
        return allTranslations.text("enterValidMonth");
      }

      // Validate year (should not be in the past)
      final currentYear = DateTime.now().year % 100; // Last two digits of the year
      if (year < currentYear) {
        return allTranslations.text("pastYear");
      }
    } else {
      return allTranslations.text("enterValidExpireDate");
    }

    return null;
  }
}