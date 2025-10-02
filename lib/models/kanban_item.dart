// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:kanban/enums/kanban_status.dart';

class KanbanItem {
  final String id;
  final KanbanStatus status;
  final String title;

  KanbanItem({
    required this.id,
    required this.status,
    required this.title,
  });

  KanbanItem copyWith({
    String? id,
    KanbanStatus? status,
    String? title,
  }) {
    return KanbanItem(
      id: id ?? this.id,
      status: status ?? this.status,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status.name,
      'title': title,
    };
  }

  factory KanbanItem.fromMap(Map<String, dynamic> map) {
    return KanbanItem(
      id: map['id'] as String,
      status: KanbanUtil.stringToStatus(map['status']),
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory KanbanItem.fromJson(String source) => KanbanItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'KanbanItem(id: $id, status: $status, title: $title)';

  @override
  bool operator ==(covariant KanbanItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.status == status &&
      other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ title.hashCode;
}
