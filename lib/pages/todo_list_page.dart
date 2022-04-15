import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController tasksController = TextEditingController();

  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      tasks.add(text);
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
                  for (String task in tasks)
                    ListTile(
                      title: Text(task),
                      subtitle: Text("15/04/22"),
                      onTap: () {
                        print("task $task");
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [
              const Expanded(
                child: Text("You have 0 task unfinished."),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[300],
                    padding: EdgeInsets.all(14),
                  ),
                  onPressed: () {},
                  child: Text("Clear all")),
            ]),
          ],
        ),
      )),
    );
  }
}
