import 'package:flutter/material.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/models/kanban_item.dart' as model;
import 'package:kanban/ui/add_edit_task_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KanbanItem extends StatelessWidget {
  final model.KanbanItem item;
  final VoidCallback onCheckbox;
  final VoidCallback onDelete;
  final VoidCallback? onStatus;
  final VoidCallback? onPrevStatus;

  const KanbanItem({
    super.key,
    required this.item,
    required this.onCheckbox,
    required this.onDelete,
    this.onStatus,
    this.onPrevStatus,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 'Done' 상태에서는 수정 화면으로 이동하지 않음
        if (item.status != KanbanStatus.done) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddEditTaskScreen(status: item.status, item: item),
          ));
        }
      },
      child: ShadCard(
        padding: const EdgeInsets.all(16),
        title: Row(
          children: [
            // Transform.translate를 사용하여 Checkbox의 위치를 왼쪽으로 조정합니다.
            Transform.translate(
              offset: const Offset(-10, 0),
              child: Checkbox(
                visualDensity: VisualDensity.compact,
                activeColor: Colors.green,
                onChanged: (_) => onCheckbox(),
                value: item.status == KanbanStatus.done,
              ),
            ),
            Expanded(
              child: Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              onPressed: onDelete,
              padding: EdgeInsets.zero,
              iconSize: 24,
              icon: const Icon(LucideIcons.x),
            ),
          ],
        ),
        description: Text(
          item.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        footer: Row(
          // 'Done' 상태일 때 오른쪽 정렬, 그 외에는 양쪽 정렬
          mainAxisAlignment: item.status == KanbanStatus.done
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('yyyy. MM. dd HH:mm').format(item.date),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              children: [
                // 'In progress' 상태일 때만 '이전(Todo)으로' 버튼 표시
                if (item.status == KanbanStatus.progress)
                  IconButton(
                    onPressed: onPrevStatus,
                    visualDensity: VisualDensity.compact,
                    iconSize: 30,
                    icon: Icon(item.status.prevIcon), // Pause Icon
                  ),
                // 'Todo' 상태일 때만 '다음(In Progress)으로' 버튼 표시
                if (item.status == KanbanStatus.todo)
                  IconButton(
                    onPressed: onStatus,
                    visualDensity: VisualDensity.compact,
                    iconSize: 30,
                    icon: Icon(item.status.nextIcon), // Play Icon
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}