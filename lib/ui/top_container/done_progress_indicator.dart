import 'package:flutter/material.dart';
import 'package:kanban/providers/kanban_provider.dart';
import 'package:provider/provider.dart';

class DoneProgressIndicator extends StatelessWidget {
  const DoneProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<KanbanProvider>(
      builder: (_, provider, child) {
        final todoCount = 3;
        final doneCount = 0;
        return Row(
          mainAxisSize: .min, // 
          spacing: 10,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: doneCount / todoCount,
                color: const Color.fromARGB(255, 107, 255, 112),
                backgroundColor: Colors.grey,
                strokeWidth: 5,
              ),
            ),

            Text('$doneCount/$todoCount 완료',style: TextStyle(fontSize: 16)),
            
          ],
        );
      }
    );
  }
}