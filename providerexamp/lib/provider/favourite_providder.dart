import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {

  final List<int> _selectedValue = [];
  List<int> get selectedValue => _selectedValue;

  void addValue(int value) {
    _selectedValue.add(value) ;
    notifyListeners();
  }

  void removeValue(int value) {
    _selectedValue.remove(value) ;
    notifyListeners();
  }
}