// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:kanban/enums/kanban_status.dart';

class KanbanItem extends StatelessWidget {

  final KanbanStatus status;
  final String title;
  final VoidCallback onCheckbox;
  final VoidCallback onDelete;
  final VoidCallback? onStatus;
  
  const KanbanItem({
    super.key,
    required this.status,
    required this.title,
    required this.onCheckbox,
    required this.onDelete,
    this.onStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
        title: Row(
          children: [
            Checkbox(
              visualDensity: .compact,
              activeColor: Colors.green,
              onChanged: (_) =>onCheckbox(),
              value: status == KanbanStatus.done, 
              ),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
              ),
            ),
            IconButton(
              onPressed: onDelete,
          padding: EdgeInsets.zero,
          iconSize: 24, 
          icon: Icon(LucideIcons.x)),
          ],
        ),
        footer: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Container(
              padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              decoration: BoxDecoration(
                color: Color(0xFFE1FBD6),
                borderRadius: .circular(4)
                ),
              child: Text('Low',style: TextStyle(fontSize: 14),),
            ),
            if (status != KanbanStatus.done)
            IconButton(onPressed: onStatus,
            visualDensity: .compact,
            iconSize: 30,
            icon: Icon(status.nextIcon),
            ),
          ],
        )

      );
      
  }
}
