import 'package:flutter/widgets.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/models/kanban_item.dart';
import 'package:uuid/uuid.dart';

class KanbanProvider with ChangeNotifier {
  KanbanStatus kanbanStatus = KanbanStatus.todo;
  List<KanbanItem> items = [];

  void _refreshUI() => notifyListeners();

  void setKanbanStatus(KanbanStatus status) {
    if (kanbanStatus == status) return;
    kanbanStatus = status;
    _refreshUI();
  }

  void addItem(KanbanStatus status, String title, String description) {
    items.add(KanbanItem(
      id: const Uuid().v4(),
      status: status,
      title: title,
      description: description,
      date: DateTime.now(),
    ));
    notifyListeners();
  }

  void deleteItemIndex(String id) {
    items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void updateItem(String id, String title, String description) {
    try {
      final item = items.firstWhere((e) => e.id == id);
      item.title = title;
      item.description = description;
      item.date = DateTime.now(); // 수정 시 날짜 업데이트
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating item: $e');
    }
  }

  void updateItemStatus(String id, KanbanStatus newStatus) {
    try {
      final item = items.firstWhere((e) => e.id == id);
      item.status = newStatus;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating item status: $e');
    }
  }

  void toggleItemCheckbox(String id) {
    try {
      final item = items.firstWhere((e) => e.id == id);
      if (item.status == KanbanStatus.done) {
        item.status = KanbanStatus.todo;
      } else {
        item.status = KanbanStatus.done;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling item checkbox: $e');
    }
  }
}