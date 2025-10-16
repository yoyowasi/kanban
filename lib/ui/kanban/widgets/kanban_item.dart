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
    final dateText = Text(
      DateFormat('yyyy. MM. dd HH:mm').format(item.date),
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black, // ✅ 시간 색상 그대로 유지
      ),
    );

    return GestureDetector(
      onTap: () {
        if (item.status != KanbanStatus.done) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddEditTaskScreen(status: item.status, item: item),
          ));
        }
      },
      child: ShadCard(
        padding: const EdgeInsets.all(16),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
  activeColor: Colors.green, // ✅ 기존 색상 유지
  onChanged: (_) {
    // ✅ Done 상태일 땐 동작만 막고 색상은 그대로 유지
    if (item.status != KanbanStatus.done) {
      onCheckbox();
    }
  },
  value: item.status == KanbanStatus.done,
),

            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            IconButton(
              onPressed: onDelete,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 24,
              icon: const Icon(LucideIcons.x),
            ),
          ],
        ),
        footer: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    if (item.status == KanbanStatus.done)
                      Align(
                        alignment: Alignment.centerRight,
                        child: dateText,
                      )
                    else
                      dateText,
                  ],
                ),
              ),
            ),
            if (item.status != KanbanStatus.done)
              Row(
                children: [
                  if (item.status == KanbanStatus.progress)
                    IconButton(
                      onPressed: onPrevStatus,
                      visualDensity: VisualDensity.compact,
                      iconSize: 30,
                      icon: Icon(item.status.prevIcon),
                    ),
                  if (item.status == KanbanStatus.todo)
                    IconButton(
                      onPressed: onStatus,
                      visualDensity: VisualDensity.compact,
                      iconSize: 30,
                      icon: Icon(item.status.nextIcon),
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
