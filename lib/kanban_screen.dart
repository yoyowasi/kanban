import 'package:flutter/material.dart';
import 'package:kanban/ui/kanban/kanban_board.dart';
import 'package:kanban/ui/top_container/top_container.dart';

class KanbanScreen extends StatelessWidget {
  const KanbanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            spacing: 25,
            crossAxisAlignment: .stretch,
            children: [
              TopContainer(),
              Expanded(
                child: KanbanBoard()),
            ],
          ),
        ),
      ),
    );
  }
}