import 'package:flutter/material.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/providers/kanban_provider.dart';
import 'package:kanban/ui/common/status_island.dart';
import 'package:kanban/ui/kanban/widgets/kanban_item.dart';
import 'package:provider/provider.dart';

class KanbanList extends StatelessWidget {
  final KanbanStatus status;
  const KanbanList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StatusIsland(status: status),
          const SizedBox(height: 15),
          Expanded(
            child: Consumer<KanbanProvider>(
              builder: (context, provider, _) {
                final items = provider.items.where((e) => e.status == status).toList();
                return ListView.separated(
                  itemCount: items.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return KanbanItem(
                      item: item,
                      onCheckbox: () {
                        provider.toggleItemCheckbox(item.id);
                      },
                      onDelete: () {
                        provider.deleteItemIndex(item.id);
                      },
                      onPrevStatus: () {
                        if (item.status == KanbanStatus.progress) {
                          provider.updateItemStatus(item.id, KanbanStatus.todo);
                        }
                      },
                      onStatus: () {
                        if (item.status == KanbanStatus.todo) {
                          provider.updateItemStatus(item.id, KanbanStatus.progress);
                        } else if (item.status == KanbanStatus.progress) {
                          provider.updateItemStatus(item.id, KanbanStatus.done);
                        }
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}