import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum KanbanStatus {
  todo, progress, done
}

extension KanbanStatusExtention on KanbanStatus{
  String get label => switch (this){
    KanbanStatus.todo => 'To-do',
    KanbanStatus.progress => 'In progress',
    KanbanStatus.done => 'Done',
  };

  Color get backgroundColor => switch (this){
    KanbanStatus.todo => const Color(0xFFF8F8F8),
    KanbanStatus.progress => const Color(0xFFEBF7FC),
    KanbanStatus.done => const Color(0xFFEDF9E8),
  };

  Color get bubbleColor => switch (this){
    KanbanStatus.todo => const Color(0xFFE8E8E8),
    KanbanStatus.progress => const Color(0xFFC8E9FF),
    KanbanStatus.done => const Color(0xFFCAF0B9),
  };

  IconData get icon => switch (this){
    KanbanStatus.todo => LucideIcons.circlePause,
    KanbanStatus.progress => LucideIcons.circlePlay,
    KanbanStatus.done => LucideIcons.circleCheck,
  };

  IconData get nextIcon => switch (this){
    KanbanStatus.todo => LucideIcons.circlePlay,
    KanbanStatus.progress => LucideIcons.circleCheck,
    KanbanStatus.done => LucideIcons.circleCheck, // 'Done'은 다음 상태 없음
  };

  IconData get prevIcon => switch (this){
    KanbanStatus.progress => LucideIcons.circlePause, // 'In progress' -> 'To-do'
    _ => LucideIcons.circle, // 기본값
  };
}

class KanbanUtil {
  static stringToStatus(String value){
    return KanbanStatus.values.firstWhere(
          (e)=> e.name == value,
      orElse: () => KanbanStatus.todo,
    );
  }
}