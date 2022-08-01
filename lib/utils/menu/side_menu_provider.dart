import 'package:flutter/material.dart';
import 'package:trid_travel/models/side_menu_model/side_menu_model.dart';

class SideMenuProvider extends ChangeNotifier {
  SideMenuItems _sideMenuItem = SideMenuItems.updatesMenu;

  SideMenuItems get sideMenuItem => _sideMenuItem;

  void setSideMenuItem(SideMenuItems sideMenuItem) {
    _sideMenuItem = sideMenuItem;
    notifyListeners();
  }
}
