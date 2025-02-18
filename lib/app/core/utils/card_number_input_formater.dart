import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var text = newValue.text.replaceAll('  ', ''); // Remove any existing spaces
    var buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces for grouping by 4
      }
    }

    var formattedText = buffer.toString();

    // Calculate and set the new caret position
    int baseOffset = newValue.selection.baseOffset;
    int offsetDelta = formattedText.length - text.length;
    int newOffset = baseOffset + offsetDelta;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: newOffset < 0 ? 0 : newOffset, // Ensure caret doesn't go out of bounds
      ),
    );
  }
}