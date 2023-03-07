import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FormEnum formEnum;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.formEnum,
  }) : super(key: key);

  bool isPrefix(String inputText) {
    return (inputText.startsWith('ghp_') ||
        inputText.startsWith('gho_') ||
        inputText.startsWith('ghu_') ||
        inputText.startsWith('ghs_') ||
        inputText.startsWith('ghr_'));
  }

  bool isFormat(String inputText) {
    return (inputText.contains(RegExp(r'[0-9]')) &&
        (inputText.contains(RegExp(r'[a-z]')) ||
            inputText.contains(RegExp(r'[a-z]'))));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 16),
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xff21262D),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xff21262D),
              ))),
      //validate format
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter $hintText';
        }
        bool isPrefixRight = isPrefix(val);
        bool isRightFormat = isFormat(val);
        if (formEnum == FormEnum.signIn) {
          if (val.length != 40 || !isPrefixRight || !isRightFormat) {
            return 'Invalid token';
          }
        }
        return null;
      },
    );
  }
}
