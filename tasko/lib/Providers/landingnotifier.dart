import 'package:flutter/material.dart';

class LandingNotifier extends ChangeNotifier {
  final bool _canswipe = false;
  bool get canswipe => _canswipe;
  void slidePage() {
    _canswipe;
    print(_canswipe);
    super.notifyListeners();
  }
}
