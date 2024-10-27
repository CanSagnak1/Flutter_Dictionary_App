import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _skor = 0;

  int get skor => _skor;

  void artir() {
    _skor++;
    notifyListeners(); // Değer değiştiğinde dinleyicilere bildirir.
  }

  void eksilt() {
    _skor--;
    notifyListeners();
  }
}
