import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TimeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final snackbar = GetSnackBar(
      backgroundColor: Color.fromRGBO(255, 219, 39, 1),
      duration: const Duration(milliseconds: 1500),
      messageText: const Text(
        'Time should be correct!',
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
      if (RegExp('[^0-9.]').hasMatch(newValue.text.replaceAll(':', ''))) {
        SnackbarController.cancelAllSnackbars();
        Get.showSnackbar(snackbar);
        return oldValue;
      }
      if (newValue.text.length > 5) return oldValue;
      if (newValue.text.length == 1) {
        if (newValue.text.isNum) {
          if (int.parse(newValue.text) >= 0 && int.parse(newValue.text) < 3) {
            SnackbarController.cancelAllSnackbars();
            return newValue;
          } else {
            SnackbarController.cancelAllSnackbars();
            Get.showSnackbar(snackbar);
            return oldValue;
          }
        } else {
          SnackbarController.cancelAllSnackbars();
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 2) {
        if (_checkHour(newValue.text)) {
          return TextEditingValue(
            text: '${newValue.text}:',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        } else {
          SnackbarController.cancelAllSnackbars();
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 3) {
        if (newValue.text[2] != ':') {
          if (newValue.text.substring(2)[0] == '0' ||
              newValue.text.substring(2)[0] == '1' ||
              newValue.text.substring(2)[0] == '2' ||
              newValue.text.substring(2)[0] == '3' ||
              newValue.text.substring(2)[0] == '4' ||
              newValue.text.substring(2)[0] == '5') {
            return TextEditingValue(
              text:
                  '${newValue.text.substring(0, 2)}:${newValue.text.substring(2)}',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end + 1,
              ),
            );
          } else {
            return TextEditingValue(
              text: '${newValue.text.substring(0, 2)}:',
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
        if (newValue.text[3].isNum) {
          if (newValue.text[3] == '0' ||
              newValue.text[3] == '1' ||
              newValue.text[3] == '2' ||
              newValue.text[3] == '3' ||
              newValue.text[3] == '4' ||
              newValue.text[3] == '5') {
            SnackbarController.cancelAllSnackbars();
            return newValue;
          } else {
            SnackbarController.cancelAllSnackbars();
            Get.showSnackbar(snackbar);
            return oldValue;
          }
        } else {
          SnackbarController.cancelAllSnackbars();
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else if (newValue.text.length == 5) {
        if (_checkMins(newValue.text)) {
          return TextEditingValue(
            text: '${newValue.text}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end,
            ),
          );
        } else {
          SnackbarController.cancelAllSnackbars();
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else {
        SnackbarController.cancelAllSnackbars();
        return newValue;
      }
    }
    if (newValue.text.length == 1 && oldValue.text.isEmpty) {
      if (newValue.text.isNum) {
        if (int.parse(newValue.text) >= 0 && int.parse(newValue.text) < 3) {
          SnackbarController.cancelAllSnackbars();
          return newValue;
        } else {
          SnackbarController.cancelAllSnackbars();
          Get.showSnackbar(snackbar);
          return oldValue;
        }
      } else {
        SnackbarController.cancelAllSnackbars();
        Get.showSnackbar(snackbar);
        return oldValue;
      }
    }

    SnackbarController.cancelAllSnackbars();
    return newValue;
  }

  bool _checkHour(String value) {
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

      if (day >= 0 && day < 24) {
        return true;
      }

      return false;
    }

    return false;
  }

  bool _checkMins(String nvalue) {
    final value = nvalue.substring(3);
    if (!value.isNum) {
      return false;
    }
    if (value.length == 2) {
      int day;
      if (value[0] == '0') {
        day = int.parse(value[1]);
      } else {
        day = int.parse(value);
      }

      if (day >= 0 && day < 60) {
        return true;
      }

      return false;
    }

    return false;
  }
}
