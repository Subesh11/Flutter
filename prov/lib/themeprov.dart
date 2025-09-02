import 'package:flutter/material.dart';
import 'package:prov/theam.dart';

class Themeprov extends ChangeNotifier {
  ThemeData _themeData = lightmode;
  ThemeData get theamdata => _themeData;
  set themedata(ThemeData themedata) {
    _themeData = themedata;
    notifyListeners();
  }

  void toggletheme() {
    if (_themeData == lightmode) {
      themedata = darkmode;
    } else {
      themedata = lightmode;
    }
  }
}
