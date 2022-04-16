import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/tasks.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.task, required this.onDelete})
      : super(key: key);

  final TaskList task;
  final Function(TaskList) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blueGrey[50],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(DateFormat("EE dd/MM/yy - HH:mm").format(task.dateTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blueGrey[700],
                  )),
              Text(
                task.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[900],
                ),
              ),
            ],
          ),
        ),
        actionExtentRatio: .25,
        actionPane: const SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            color: Colors.indigo[600],
            icon: Icons.archive,
            caption: "Archive",
            onTap: () {},
          ),
          IconSlideAction(
            color: Colors.blueGrey,
            icon: Icons.share,
            caption: "Share",
            onTap: () {},
          ),
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red[400],
            icon: Icons.delete,
            caption: "Delete",
            onTap: () {
              onDelete(task);
            },
          ),
        ],
      ),
    );
  }
}
