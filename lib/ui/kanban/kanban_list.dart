import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kanban/enums/kanban_status.dart';

class KanbanList extends StatelessWidget {
  final KanbanStatus status;
  const KanbanList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        status.label,
        style: TextStyle(fontSize: 40),
        ),
      );
  }
}