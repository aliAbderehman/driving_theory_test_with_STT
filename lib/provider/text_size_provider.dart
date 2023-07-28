import 'package:abel_proj_01/shared/text_Size_prefs.dart';
import 'package:flutter/material.dart';

class TextSizeProvider with ChangeNotifier {
  TextSizePref textSizePrefs = TextSizePref();
  bool _textSize = false;
  bool get getTextSize => _textSize;

  set setTextSize(bool value) {
    _textSize = value;
    textSizePrefs.setTextSize(value);
    notifyListeners();
  }
}
