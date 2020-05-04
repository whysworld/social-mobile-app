import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueTextClean = newValue.text.replaceAll(":", "");
    final int newTextLength = newValueTextClean.length;
    int selectionIndex = newValue.selection.end;
    final StringBuffer newText = StringBuffer();

    if (newTextLength < 3) {
      newText.write(newValueTextClean);
      selectionIndex = newTextLength;
    } else if (newTextLength == 3) {
      newText.write(
          "${newValueTextClean.substring(0, 1)}:${newValueTextClean.substring(1, 3)}");
      selectionIndex = newTextLength + 1;
    } else if (newTextLength == 4) {
      newText.write(
          "${newValueTextClean.substring(0, 2)}:${newValueTextClean.substring(2, 4)}");
      selectionIndex = newTextLength + 1;
    }

    // Dump the rest.
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(0, 5));
      selectionIndex = 5;
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
