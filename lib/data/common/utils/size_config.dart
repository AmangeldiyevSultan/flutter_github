import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;

  static late double screenWidth;

  static late double screenHeight;

  static double? defaultSize;

  static late Orientation orientation;

  static void init(BuildContext context) {
    // Object represent MediaQuery data of specific context
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  // Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight;

    return (inputHeight / (orientation == Orientation.portrait ? 737 : 392)) *
        screenHeight;
  }

  // Get the proportionate height as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth;

    return (inputWidth / (orientation == Orientation.portrait ? 392 : 737)) *
        screenWidth;
  }
}
