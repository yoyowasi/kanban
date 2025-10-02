import 'package:flutter/material.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/providers/kanban_provider.dart';
import 'package:kanban/ui/kanban/kanban_list.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({super.key});

   @override
  Widget build(BuildContext context) {
    return Consumer<KanbanProvider>(
      builder: (context, provider, child) {
        final status = provider.kanbanStatus;
        return ShadTabs(
          value: status,
          expandContent:true,
          contentConstraints:BoxConstraints.expand(
            height: 0
          ),
          tabs: KanbanStatus.values
              .map(
                (e) {
                  return ShadTab(
                    onPressed: () => provider.setKanbanStatus(e),
                  value: e, //
                  content: KanbanList(status: e),
                  child: Text(e.label),
                );
                }
              )
              .toList(),
        );
      },
    );
  }
}
