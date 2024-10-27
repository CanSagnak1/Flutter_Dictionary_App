import 'package:flutter/material.dart';

class AppColors {
  List<Color> renkPaleti = [
    const Color.fromRGBO(163, 223, 255, 1.0), // Açık Mavi
    const Color.fromRGBO(255, 248, 176, 1.0), // Yumuşak Sarı
    const Color.fromRGBO(255, 111, 97, 1.0), // Mercan Pembesi
    const Color.fromRGBO(191, 162, 219, 1.0), // Lavanta
    const Color.fromRGBO(167, 243, 208, 1.0), // Mint Yeşili
    const Color.fromRGBO(255, 184, 140, 1.0), // Turuncu Şeftali
  ];
  //Appbar renkleri
  static const Color appbarText = Color.fromARGB(255, 46, 74, 46);
  static const Color appbarBg = Color.fromARGB(235, 149, 198, 174);
  static const Color appbarIcon = Color.fromARGB(255, 46, 74, 46);

  //Drawer renkleri
  static const Color drawerBg = Color.fromARGB(235, 149, 198, 174);
  static const Color drawerHeaderText = Color.fromARGB(255, 46, 74, 46);
  static const Color drawerIcon = Color.fromRGBO(163, 223, 255, 1.0);
  static const Color drawerText = Color.fromARGB(255, 46, 74, 46);

  //Categories renkleri
  static const Color scafoldBg = Colors.white;
  static const Color containerDefaultBg = Color.fromARGB(109, 149, 198, 174);
  static const Color containerPressedBg = Color.fromARGB(232, 149, 198, 174);
  static const Color containerBorderColor = Colors.white;
  static const Color containerTextDefault = Color.fromARGB(255, 46, 74, 46);
  static const Color containerTextPressed = Color.fromARGB(255, 27, 43, 27);
}
