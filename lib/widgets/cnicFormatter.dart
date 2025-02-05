import 'package:flutter/services.dart';

class CnicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove any non-numeric characters
    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply the correct formatting for CNIC: 12345-6789012-3
    if (newText.length > 5 && newText.length <= 12) {
      newText = '${newText.substring(0, 5)}-${newText.substring(5)}';
    } else if (newText.length > 12) {
      newText =
          '${newText.substring(0, 5)}-${newText.substring(5, 12)}-${newText.substring(12)}';
    }

    // Limit input to a maximum of 15 characters (including the dashes)
    if (newText.length > 15) {
      newText = newText.substring(0, 15);
    }

    // Ensure the cursor stays at the right place
    int cursorPosition = newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
