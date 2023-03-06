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
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter $hintText';
        }

        bool isPrefix = (val.startsWith('ghp_') ||
            val.startsWith('gho_') ||
            val.startsWith('ghu_') ||
            val.startsWith('ghs_') ||
            val.startsWith('ghr_'));
        bool isRightFormat = (val.contains(RegExp(r'[0-9]')) &&
            (val.contains(RegExp(r'[a-z]')) || val.contains(RegExp(r'[a-z]'))));
        if (formEnum == FormEnum.signIn) {
          if (val.length != 40 || !isPrefix || !isRightFormat) {
            return 'Invalid token';
          }
        }
        return null;
      },
    );
  }
}
