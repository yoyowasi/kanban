import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              activeColor: Colors.green,
              onChanged: (_) => onCheckbox(),
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
        // 'description'을 footer로 옮기지 않고, ShadCard의 기본 description 슬롯을 사용합니다.
        // 이렇게 하면 Done 상태에서도 내용이 보이게 됩니다.
        description: Padding(
          padding: const EdgeInsets.only(left: 36, top: 4), // 체크박스 너비만큼 들여쓰기
          child: Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
        footer: Padding(
          padding: const EdgeInsets.only(left: 36, top: 8), // 체크박스 너비만큼 들여쓰기
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 1. 모든 상태에서 시간 색상을 검은색으로 변경합니다.
              Text(
                DateFormat('yyyy. MM. dd HH:mm').format(item.date),
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),

              // 'Done' 상태가 아닐 때만 버튼들을 표시합니다.
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
      ),
    );
  }
}