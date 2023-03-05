import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/colors.dart';
import 'package:flutter_github/features/auth/screens/auth_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  final String? routeName;
  const SplashScreen({super.key, this.routeName});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/Group.svg',
                width: 220,
                height: 220,
              ),
              RichText(
                  text: const TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'ICE',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                TextSpan(text: 'ROCK', style: TextStyle(fontSize: 50)),
              ]))
            ]),
      ),
    );
  }
}
