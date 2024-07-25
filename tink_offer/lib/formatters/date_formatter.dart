import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final snackbar = GetSnackBar(
      backgroundColor: Color.fromRGBO(255, 219, 39, 1),
      duration: const Duration(milliseconds: 1500),
      messageText: const Text(
        'Date should be correct!',
        style: const TextStyle(
          fontFamily: 'Sarabun',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(24, 24, 24, 1),
        ),
      ),
    );

    if (newValue.text.length > oldValue.text.length &&
        newValue.text.isNotEmpty &&
        oldValue.text.isNotEmpty) {
      if (RegExp('[^0-9.]').hasMatch(newValue.text)) {
        Get.showSnackbar(snackbar);
        return oldValue;
      }
      if (newValue.text.length > 10) return oldValue;
      if (newValue.text.length == 1) {
        if (newValue.text.isNum) {
          if (int.parse(newValue.text) >= 0 && int.parse(newValue.text) <= 3) {
            SnackbarController.cancelAllSnackbars();
            return newValue;
          } else {
            Get.showSnackbar(snackbar);
            return oldValue;
          }
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 2 || newValue.text.length == 5) {
        if (_checkDate(newValue.text)) {
          return TextEditingValue(
            text: '${newValue.text}.',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 3) {
        if (newValue.text[2] != '.') {
          if (newValue.text.substring(2)[0] == '0' ||
              newValue.text.substring(2)[0] == '1') {
            return TextEditingValue(
              text:
                  '${newValue.text.substring(0, 2)}.${newValue.text.substring(2)}',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end + 1,
              ),
            );
          } else {
            return TextEditingValue(
              text: '${newValue.text.substring(0, 2)}.',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end,
              ),
            );
          }
        } else {
          SnackbarController.cancelAllSnackbars();
          return newValue;
        }
      } else if (newValue.text.length == 4) {
        if (newValue.text[newValue.text.length - 1].isNum) {
          if (newValue.text[3] == '0' || newValue.text[3] == '1') {
            SnackbarController.cancelAllSnackbars();
            return newValue;
          } else {
            Get.showSnackbar(snackbar);
            return oldValue;
          }
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 6) {
        if (newValue.text[5] != '.') {
          if (newValue.text.substring(5) == DateTime.now().year.toString()[0]) {
            return TextEditingValue(
              text:
                  '${newValue.text.substring(0, 5)}.${newValue.text.substring(5)}',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end + 1,
              ),
            );
          } else {
            return TextEditingValue(
              text: '${newValue.text.substring(0, 5)}.',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end,
              ),
            );
          }
        } else {
          SnackbarController.cancelAllSnackbars();
          return newValue;
        }
      }
    }
    if (newValue.text.length == 1 && oldValue.text.isEmpty) {
      if (newValue.text.isNum) {
        if (int.parse(newValue.text) >= 0 && int.parse(newValue.text) <= 3) {
          SnackbarController.cancelAllSnackbars();
          return newValue;
        } else {
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else {
        Get.showSnackbar(snackbar);
        return oldValue;
      }
    }

    SnackbarController.cancelAllSnackbars();
    return newValue;
  }

  bool _checkYear(String value) {
    final curYear = DateTime.now().year;
    final searchYear = int.parse(value.substring(6));
    if (searchYear <= curYear) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkDate(String value) {
    if (!value[value.length - 1].isNum) {
      return false;
    }
    if (value.length == 2) {
      int day;
      if (value[0] == '0') {
        day = int.parse(value[1]);
      } else {
        day = int.parse(value);
      }

      if (day > 0 && day < 32) {
        return true;
      }

      return false;
    } else {
      final date = value.substring(3);
      int mounth;

      if (date[0] == '0') {
        mounth = int.parse(date[1]);
      } else {
        mounth = int.parse(date);
      }

      if (mounth > 0 && mounth < 13) {
        return true;
      }

      return false;
    }
  }
}
