import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int _count = 0; // The private variable

  // The getter
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
