import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  int _selectedTab = 1;

  int get selectedTab => _selectedTab;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    _selectedTab = index;
    notifyListeners();
  }
}
