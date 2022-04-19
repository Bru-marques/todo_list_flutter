import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/tasks.dart';

const todoListKey = "todo_list";

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<TaskList>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? "[]";
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => TaskList.fromJson(e)).toList();
  }

  void saveTodoList(List<TaskList> tasks) {
    final jsonString = json.encode(tasks);
    sharedPreferences.setString(todoListKey, jsonString);
  }
}
