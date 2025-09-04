import 'package:flutter/widgets.dart';

class KanbanProvider with ChangeNotifier {
  int value = 0;

  void addValue(){
    value++;
    notifyListeners();
    debugPrint('변수 변경:  $value');
  }
}