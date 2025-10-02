import 'package:flutter/widgets.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/models/kanban_item.dart';
import 'package:uuid/uuid.dart';

class KanbanProvider with ChangeNotifier {
  KanbanStatus kanbanStatus = .todo;
  List<KanbanItem> items = [];

  // refeshUI()
  void _refreshUI() => notifyListeners();

  void setKanbanStatus(KanbanStatus status){
    if (kanbanStatus == status) return;
    kanbanStatus = status;
    _refreshUI();
  }

  // 아이템 추가
  void addItem(KanbanStatus status, String title){
    items.add(KanbanItem(
      id:Uuid().v4(), 
      status: status,
      title: title,
      )
    );
    notifyListeners();
  }
  // 아이템 삭제
  void deleteItemIndex(String id){
    items.removeWhere((e)=> e.id == id);
    notifyListeners();
  }
  
}
