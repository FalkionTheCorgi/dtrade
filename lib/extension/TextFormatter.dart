import 'package:flutter/services.dart';

class CustomNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    int number = int.tryParse(digitsOnly) ?? 0;

    String formattedValue = formatNumber(number);

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

String formatNumber(int number) {
  String numberString = number.toString();
  int length = numberString.length;

  if (length <= 3) {
    return numberString;
  } else {
    int remainder = length % 3;
    String formattedString = numberString.substring(0, remainder);

    while (remainder < length) {
      if (formattedString.isNotEmpty) {
        formattedString += '.';
      }
      formattedString += numberString.substring(remainder, remainder + 3);
      remainder += 3;
    }

    return formattedString;
  }
}
