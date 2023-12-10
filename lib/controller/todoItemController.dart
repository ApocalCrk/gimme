import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/ToDoItem.dart';
import 'package:http/http.dart';

class ToDoItemController {
  Future <List<ToDoItem>> getToDoItemByToDoId(int id_todo) async {
    try {
      print(id_todo);
      List<dynamic> list = [];
      var response = await get(Uri.http(url, '$endpoint/todo_item/getToDoItemByToDoId/$id_todo')).then((value) {
        for (var item in jsonDecode(value.body)['data']) {
          list.add(item);
        }
      });
      var todos = list.map((e) => ToDoItem.fromJson(e)).toList();
      print('masuk print');
      print(todos);
      return todos;
    }catch(e){
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<String?> createToDoItemByToDoId(int id_todo, String todo_item, String time) async {
    try{
      var res = await post(Uri.http(url, '$endpoint/todo_item/createToDoItem'),
      body: {
        'id_todo': id_todo.toString(),
        'todo_item': todo_item,
        'time': time,
      });
      print("masuk create");
      return res.body;
    }catch(e){
      print("masuk error");
      return null;
    }
  }

  Future<String?> updateToDoItem(int id_todo_item, String todo_item, String time) async {
    try{
      var res = await put(Uri.http(url, '$endpoint/todo_item/updateToDoItem'),
      body: {
        'id_todo_item': id_todo_item.toString(),
        'todo_item': todo_item,
        'time': time,
      });
      return res.body;
    }catch(e){
      return null;
    }
  }

  Future<String?> deleteToDoItem(int id_todo_item) async {
    try{
      var res = await delete(Uri.http(url, '$endpoint/todo_item/deleteToDoItem/$id_todo_item'));
      return res.body;
    }catch(e){
      return null;
    }
  }
}