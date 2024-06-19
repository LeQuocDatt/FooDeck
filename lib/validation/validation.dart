import 'package:template/source/export.dart';

class Validation {
  static RegExp nameRegex = RegExp(
      r'^([^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s?[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+?\S)$');
  static RegExp emailRegex = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static RegExp passRegex = RegExp(
      r'^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
  static RegExp cardNameRegex = RegExp(r'^([\w]+\s[\w]+\s?[\w]+?\S)$');
}

class CardNumberFormatter extends TextInputFormatter {
  final int textIndex;
  final String replaceText;

  CardNumberFormatter({required this.textIndex, required this.replaceText});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;
    final int selectIndex = newText.length - newValue.selection.end;
    int offset = 0;
    final StringBuffer newTextBuffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && i % textIndex == 0) {
        newTextBuffer.write(replaceText);
        if (newValue.selection.end >= i + offset) {
          offset++;
        }
      }
      newTextBuffer.write(newText[i]);
    }
    return TextEditingValue(
        text: newTextBuffer.toString(),
        selection: TextSelection.collapsed(
            offset: newTextBuffer.length - selectIndex));
  }
}
