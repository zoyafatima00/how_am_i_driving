import 'package:flutter/services.dart';

class ContactNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove anything that is not a number
    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Format the number with a dash after the 4th digit
    if (newText.length > 4 && newText.length <= 7) {
      newText = '${newText.substring(0, 4)}-${newText.substring(4)}';
    } else if (newText.length > 7) {
      newText = '${newText.substring(0, 4)}-${newText.substring(4, 11)}';
    }

    // Limit the input to 12 characters (including the dash)
    if (newText.length > 12) {
      newText = newText.substring(0, 12);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
