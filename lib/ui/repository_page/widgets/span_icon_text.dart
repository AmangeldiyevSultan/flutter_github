import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpanIconText extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color color;
  final String? assetLink;
  final int amount;
  const SpanIconText(
      {super.key,
      required this.text,
      this.icon,
      required this.color,
      required this.amount,
      this.assetLink});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: color,
          ),
        const SizedBox(
          width: 5,
        ),
        if (assetLink != null)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: SvgPicture.asset(
              assetLink!,
            ),
          ),
        Text(
          amount.toString(),
          style: TextStyle(fontSize: 16, color: color),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
