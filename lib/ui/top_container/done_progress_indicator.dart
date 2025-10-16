import 'package:flutter/material.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/providers/kanban_provider.dart';
import 'package:provider/provider.dart';

class DoneProgressIndicator extends StatelessWidget {
  const DoneProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<KanbanProvider>(
      builder: (_, provider, child) {
        final totalCount = provider.items.length;
        final doneCount = provider.items.where((e) => e.status == KanbanStatus.done).length;
        // 0으로 나누는 것을 방지
        final progress = totalCount > 0 ? doneCount / totalCount : 0.0;

        return Row(
          mainAxisSize: MainAxisSize.min, //
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: progress,
                color: const Color.fromARGB(255, 107, 255, 112),
                backgroundColor: Colors.grey,
                strokeWidth: 5,
              ),
            ),
            const SizedBox(width: 10),
            Text('$doneCount/$totalCount 완료',style: const TextStyle(fontSize: 16)),
          ],
        );
      }
    );
  }
}