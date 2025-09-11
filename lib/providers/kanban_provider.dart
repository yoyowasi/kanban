import 'package:flutter/widgets.dart';
import 'package:kanban/enums/kanban_status.dart';

class KanbanProvider with ChangeNotifier {
  KanbanStatus kanbanStatus = .todo;

  // refeshUI()
  void _refreshUI() => notifyListeners();

  void setKanbanStatus(KanbanStatus status){
    if (kanbanStatus == status) return;
    kanbanStatus = status;
    _refreshUI();
  }
}
