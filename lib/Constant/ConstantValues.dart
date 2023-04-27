import 'dart:math';

import 'package:flutter/material.dart';

const primaryColor = Color(0xff4fc3f7);

const darkThemeColor = Color(0xff4fc3f7);
const thirdColor = Color(0xff173143);
const editFeildText = Color(0xff173143);
const customField = Color(0xff8a948f);
const cardSubTextColor = Color(0xff9d9d9d);
const buttonColor = Color(0xff4fc3f7);

const optionCardColor = Color(0xff454545);
const stackBodyHeight = 0.8;
const dividerWidth = 2.0;
const profileSubTextColor = Color(0xff9d9d9d);
const leftCardPadding = 15.0;
const buttonWidth = 0.95;
const mainPadding = 0.05;
const cardRadius = 5.0;
const hor_padding = 8.0;
const button_radius = 5.0;
const listCardElevation = 1.0;
const standardPadding = 8.0;
const reversationCardBorder = Color(0xffe5eced);
const gridCardHeight = 165.0;
const bodyColor = Color(0xfff2f2f3);
const featureBackground = Color(0xffe74c3c);
const EdgeInsets templatePadding =
    EdgeInsets.only(top: 25, right: 20, left: 20);
MaterialColor primarySwatch = generateMaterialColor(primaryColor);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
