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
      KanbanStatus.todo => Color(0xFFF8F8F8),
      KanbanStatus.progress => Color(0xFFEBF7FC),
      KanbanStatus.done => Color(0xFFEDF9E8),
    };

    Color get bubbleColor => switch (this){
      KanbanStatus.todo => Color(0xFFE8E8E8),
      KanbanStatus.progress => Color(0xFFC8E9FF),
      KanbanStatus.done => Color(0xFFCAF0B9),
    };

     IconData get icon => switch (this){
      KanbanStatus.todo => LucideIcons.circlePause,
      KanbanStatus.progress => LucideIcons.circlePlay,
      KanbanStatus.done => LucideIcons.circleCheck,
    };

      IconData get nextIcon => switch (this){
      KanbanStatus.todo => LucideIcons.circlePlay,
      KanbanStatus.progress => LucideIcons.circlePause,
      KanbanStatus.done => LucideIcons.circleCheck,
    };
  }

  class KanbanUtil {
    static stringToStatus(String value){
      // 1번. if else 사용
      // KanbanStatus status;
      // if (value =='progress'){
      //   status = KanbanStatus.progress;
      // }else if(value == 'done'){
      //   status = KanbanStatus.done;
      // }else{
      //   status = KanbanStatus.done;
      // }
      // return status;
      //---------------------
      // 2번재 Swich-case 
      // return switch (value){
      //   'progress' => KanbanStatus.progress,
      //   'done' => KanbanStatus.done,
      //   _=> KanbanStatus.todo,
      // };
      //----------------------------------

      //3번째 
      return KanbanStatus.values.firstWhere(
        (e)=> e.name == value,
        orElse: () => KanbanStatus.todo,
      );
    }
  }