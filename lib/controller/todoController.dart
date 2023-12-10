import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/ToDo.dart';
import 'package:http/http.dart';

class ToDoController {
  

  Future<List<ToDo>> getAllToDO() async {
    try {
      List<dynamic> list = [];
      var response = await get(Uri.http(url, '$endpoint/todo/getAllToDo')).then((value) {
        for (var item in jsonDecode(value.body)['data']) {
          list.add(item);
        }
      });
      var todos = list.map((e) => ToDo.fromJson(e)).toList();
      print(todos);
      return todos;
    }catch(e){
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future <List<ToDo>> getToDoByUser(int id_user) async {
    try {
      List<dynamic> list = [];
      var response = await get(Uri.http(url, '$endpoint/todo/getToDoByUser/$id_user')).then((value) {
        for (var item in jsonDecode(value.body)['data']) {
          list.add(item);
        }
      });
      var todos = list.map((e) => ToDo.fromJson(e)).toList();
      return todos;
    }catch(e){
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<String?> createToDoByUser(int id_user, String nama_todo) async {
    try{
      var res = await post(Uri.http(url, '$endpoint/todo/createToDoByUser'),
      body: {
        'id_user': id_user.toString(),
        'nama_todo': nama_todo
      });
      return res.body;
    }catch(e){
      return null;
    }
  }

  Future<String?> updateToDo(int id_todo, String nama_todo) async {
    try{
      var res = await put(Uri.http(url, '$endpoint/todo/updateToDo'),
      body: {
        'id_todo': id_todo.toString(),
        'nama_todo': nama_todo
      });
      return res.body;
    }catch(e){
      return null;
    }
  }

  Future<String?> deleteToDo(int id_todo) async {
    try{
      var res = await delete(Uri.http(url, '$endpoint/todo/deleteToDoById/$id_todo'));
      return res.body;
    }catch(e){
      return null;
    }
  }

}
