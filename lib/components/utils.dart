import 'package:calculator/components/constants.dart';
import 'package:calculator/components/enums.dart';
import 'package:flutter/material.dart';

mixin Util {

  switchMode(ThemeModeEnum mode) {
    if (mode == ThemeModeEnum.darkMode) {
      clrBackground = bgBlack;
      clrNumbers = lightBlack;
      clrButtonBlue = blue;
      clrButtonLightGrey = darkGrey;
      clrMoon = blue;
      clrSun = blue;
      clrText = white;
      clrTextTop = whiteWithOpacity;
      clrSwitchBg = lightBlack;
      clrSwitchRoundBg = darkGrey;
    } else if (mode == ThemeModeEnum.lightMode) {
      clrBackground = bgWhite;
      clrNumbers = white;
      clrButtonBlue = blue;
      clrButtonLightGrey = lightGrey;
      clrMoon = blue;
      clrSun = blue;
      clrText = black;
      clrTextTop = blackWithOpacity;
      clrSwitchBg = white;
      clrSwitchRoundBg = lightGrey;
    }
  }

  Color getButtonColor(int index) {
    if (index == 0 || index == 1 || index == 2) {
      return clrButtonLightGrey;
    } else if (index == 3 ||
        index == 7 ||
        index == 11 ||
        index == 15 ||
        index == 19) {
      return clrButtonBlue;
    } else {
      return clrNumbers;
    }
  }

  Color getButtonTextColor(int index) {
    if (index == 3 || index == 7 || index == 11 || index == 15 || index == 19) {
      return white;
    } else {
      return clrText;
    }
  }

}
