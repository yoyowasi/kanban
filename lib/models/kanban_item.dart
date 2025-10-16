// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:kanban/enums/kanban_status.dart';

class KanbanItem {
  final String id;
  KanbanStatus status;
  String title;
  String description;
  DateTime date;

  KanbanItem({
    required this.id,
    required this.status,
    required this.title,
    required this.description,
    required this.date,
  });

  KanbanItem copyWith({
    String? id,
    KanbanStatus? status,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return KanbanItem(
      id: id ?? this.id,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status.name,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory KanbanItem.fromMap(Map<String, dynamic> map) {
    return KanbanItem(
      id: map['id'] as String,
      status: KanbanUtil.stringToStatus(map['status']),
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory KanbanItem.fromJson(String source) => KanbanItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'KanbanItem(id: $id, status: $status, title: $title, description: $description, date: $date)';
  }

  @override
  bool operator ==(covariant KanbanItem other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.status == status &&
      other.title == title &&
      other.description == description &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      status.hashCode ^
      title.hashCode ^
      description.hashCode ^
      date.hashCode;
  }
}