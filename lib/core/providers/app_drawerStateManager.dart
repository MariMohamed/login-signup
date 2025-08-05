import 'dart:typed_data';

import 'package:flutter/material.dart';

class DrawerStateInfo with ChangeNotifier {
  int _currentDrawer = 0;
  Uint8List? _avatarImage;

  int get getCurrentDrawer => _currentDrawer;
  Uint8List? get avatarImage => _avatarImage;

  void setCurrentDrawer(int drawer) {
    _currentDrawer = drawer;
    notifyListeners();
  }

  void setAvatarImage(Uint8List? image) {
    _avatarImage = image;
    notifyListeners();
  }
}
