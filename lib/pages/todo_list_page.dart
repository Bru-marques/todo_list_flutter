import 'package:flutter/material.dart';

import '../models/tasks.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController tasksController = TextEditingController();

  List<TaskList> tasks = [];
  TaskList? deletedTask;
  int? deletedTaskPosition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tasksController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Add a task",
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[300],
                        padding: EdgeInsets.all(4),
                      ),
                      onPressed: () {
                        String text = tasksController.text;
                        setState(() {
                          TaskList newTaskList = TaskList(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          tasks.add(newTaskList);
                        });
                        tasksController.clear();
                      },
                      child: Icon(Icons.add_rounded, size: 50),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (TaskList task in tasks)
                        TodoListItem(
                          task: task,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child:
                          Text("You have ${(tasks.length)} task unfinished."),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[300],
                          padding: EdgeInsets.all(14),
                        ),
                        onPressed: () {
                          showDeleteTasksConfirmationDialog();
                        },
                        child: Text("Clear all")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(TaskList task) {
    deletedTask = task;
    deletedTaskPosition = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Task ${(task.title)} was deleted.",
              style: TextStyle(color: Colors.blueGrey[900])),
          backgroundColor: Colors.blueGrey[100],
          action: SnackBarAction(
            label: "Undo",
            textColor: Colors.purple[400],
            onPressed: () {
              setState(
                () {
                  tasks.insert(deletedTaskPosition!, deletedTask!);
                },
              );
            },
          ),
          duration: const Duration(seconds: 5)),
    );
  }

  void showDeleteTasksConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Clear all tasks"),
        content: Text("Are you sure you want to clear all tasks?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blueGrey[700]),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.red[400]),
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTasks();
            },
            child: Text("Clear all"),
          ),
        ],
      ),
    );
  }

  void deleteAllTasks() {
    setState(() {
      tasks.clear();
    });
  }
}
