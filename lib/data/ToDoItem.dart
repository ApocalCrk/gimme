import 'package:flutter/material.dart';

class ToDoItem {
  final int id_todo_item, id_todo;
  final String todo_item;
  final TimeOfDay? time;
  DateTime? created_at, updated_at;

  ToDoItem({
    required this.id_todo_item,
    required this.id_todo,
    required this.todo_item,
    required this.time,
    this.created_at,
    this.updated_at
  });

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      id_todo_item: json['id_todo_item'],
      id_todo: json['id_todo'],
      todo_item: json['todo_item'],
      time: TimeOfDay(hour:int.parse(json['time'].split(":")[0]),minute: int.parse(json['time'].split(":")[1])),
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_todo_item': id_todo_item.toString(),
      'id_todo': id_todo.toString(),
      'todo_item': todo_item.toString(),
      'time': time.toString(),
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString()
    };
  }

  String formatedTime(){
    return '${time!.hour}:${time!.minute}';
  }
}