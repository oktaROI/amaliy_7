import 'package:flutter/material.dart';
import 'package:amaliy7/add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Widget _builItem() {
    return Container(
      child: ListTile(
        title: Text("task title"),
        subtitle: Text("May 03"),
        trailing: Checkbox(
          value: true,
          onChanged: (bool? value) {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(),
            ),
           );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.yellow,
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (
                BuildContext context,
                int index,
                ) {
              if (index == 0) {
                return Container(
                  child: Text(
                    "My Task",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else
                return _builItem();
            }),
      ),
    );
  }
}