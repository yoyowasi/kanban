import 'package:flutter/material.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/ui/common/status_island.dart';

class KanbanList extends StatelessWidget {
  final KanbanStatus status;
  const KanbanList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
      color: status.backgroundColor,
      borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 15,
        children: [
          StatusIsland(status: status),
          Expanded(
            child: ListView.separated(
              itemCount: 10000,
              shrinkWrap: true,
              separatorBuilder: (context, index){
                return SizedBox(height: 10,);
              }, 
              itemBuilder: (context, index){
                return Text('${DateTime.now()}',
                style: TextStyle(fontSize: 20),);
              } 
              ),
          )
        ],
      ),
    );
  }
}