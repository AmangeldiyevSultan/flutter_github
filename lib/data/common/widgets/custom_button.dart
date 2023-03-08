import 'package:flutter/material.dart';
import 'package:flutter_github/data/common/utils/size_config.dart';
import 'package:flutter_github/data/common/widgets/loader.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? color;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isLoading = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ElevatedButton(
        style: ButtonStyle(
            // button radius
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                        color:
                            color != null ? Colors.grey : Colors.transparent))),
            elevation: MaterialStateProperty.all<double>(0),
            //backgroundcolor
            backgroundColor: color == null
                ? MaterialStateProperty.all<Color>(kButtonColor)
                : MaterialStateProperty.all<Color>(color!),
            minimumSize: MaterialStateProperty.all<Size>(Size(double.maxFinite,
                SizeConfig.getProportionateScreenHeight(48)))),
        // on press action
        onPressed: onTap,
        child: isLoading
            ? const SizedBox(width: 23, height: 23, child: Loader())
            : Text(
                text,
                style: const TextStyle(fontSize: 16),
              ));
  }
}
