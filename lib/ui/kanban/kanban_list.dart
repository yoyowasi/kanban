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
            child: Consumer<KanbanProvider>(
              builder: (context,provider,_){
                final items = provider.items;
                final searchedItems = items.where((e) => e.status == status).toList();
                return ListView.separated(
                itemCount: searchedItems.length,
                shrinkWrap: true,
                separatorBuilder: (context, index){
                  return SizedBox(height: 20,);
                },
                itemBuilder: (context, index){
                  final item = searchedItems[index];
                  return KanbanItem(
                    status: status,
                    title: item.title,
                    onCheckbox: (){
                      debugPrint('$status => 체크박스');
                    },
                    onDelete: () {
                      debugPrint('$status => 삭제버튼');
                      provider.deleteItemIndex(item.id);
                    },
                    onStatus: () {

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