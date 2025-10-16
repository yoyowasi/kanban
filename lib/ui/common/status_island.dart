import 'package:flutter/material.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/providers/kanban_provider.dart';
import 'package:kanban/ui/add_edit_task_screen.dart';
import 'package:kanban/ui/themes/app_size.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StatusIsland extends StatelessWidget {
  final KanbanStatus status;
  const StatusIsland({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.statusIslandHeight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: status.bubbleColor,
                borderRadius: BorderRadius.circular(
                  AppSize.statusIslandHeight + 10,
                ),
              ),
              child: Row(
                children: [
                  Icon(status.icon, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      status.label,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 7),
          _buildCircleBubble(
            child: Consumer<KanbanProvider>(
              builder: (context, provider, child) {
                final count = provider.items.where((e) => e.status == status).length;
                return Text(
                  count.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 7),
          _buildCircleBubble(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddEditTaskScreen(status: status),
              ));
            },
            visible: status != KanbanStatus.done,
            child: const Icon(
              LucideIcons.plus,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleBubble({
    required Widget child,
    bool visible = true,
    VoidCallback? onTap,
  }) {
    if (!visible) {
      return SizedBox.fromSize(
        size: Size.fromWidth(AppSize.statusIslandHeight),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.statusIslandHeight / 2),
      child: Container(
        width: AppSize.statusIslandHeight,
        height: AppSize.statusIslandHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: status.bubbleColor,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}