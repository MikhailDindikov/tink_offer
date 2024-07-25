import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogTextField extends StatelessWidget {
  final Widget leadingIcon;
  final TextEditingController tinkCt;
  final String helperText;
  final List<Widget> tinkIcons;
  final bool isError;
  final List<TextInputFormatter> formatters;
  const DialogTextField({
    super.key,
    required this.leadingIcon,
    required this.tinkCt,
    required this.helperText,
    required this.tinkIcons,
    this.isError = false,
    this.formatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextFormField(
        inputFormatters: formatters,
        style: TextStyle(
          fontFamily: 'Sarabun',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(245, 247, 248, 1),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 10),
          hintText: helperText,
          hintStyle: TextStyle(
            fontFamily: 'Sarabun',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isError ? Colors.red : Color.fromRGBO(245, 247, 248, 0.25),
          ),
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: tinkIcons,
          ),
          prefixIcon: leadingIcon,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color.fromRGBO(245, 247, 248, 0.25),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color.fromRGBO(245, 247, 248, 0.25),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color.fromRGBO(245, 247, 248, 0.25),
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color.fromRGBO(245, 247, 248, 0.25),
            ),
          ),
          hoverColor: Color.fromRGBO(245, 247, 248, 0.25),
          focusColor: Color.fromRGBO(245, 247, 248, 0.25),
        ),
        cursorColor: Color.fromRGBO(245, 247, 248, 1),
        controller: tinkCt,
      ),
    );
  }
}

class DialogDefaultTextField extends StatelessWidget {
  final TextEditingController tinkCt;
  final String helperText;
  final bool isError;
  const DialogDefaultTextField({
    super.key,
    required this.tinkCt,
    required this.helperText,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextFormField(
        style: TextStyle(
          fontFamily: 'Sarabun',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(245, 247, 248, 1),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 10),
          hintText: helperText,
          hintStyle: TextStyle(
            fontFamily: 'Sarabun',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isError ? Colors.red : Color.fromRGBO(142, 142, 147, 1),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hoverColor: Color.fromRGBO(245, 247, 248, 0.25),
          focusColor: Color.fromRGBO(245, 247, 248, 0.25),
        ),
        cursorColor: Color.fromRGBO(245, 247, 248, 1),
        controller: tinkCt,
      ),
    );
  }
}
