import 'package:amaliy7/database_helper.dart';
import 'package:amaliy7/task.dart';
import 'package:flutter/material.dart';
import 'package:amaliy7/add_task_screen.dart';
import 'package:intl/intl.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> _taskList;
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  Widget _builItem(Task task) {
    return Container(
      child: ListTile(
        title: Text(task.title!),
        subtitle: Text(_dateFormat.format(task.date)),
        trailing: Checkbox(
          value: task.status == 0 ? false : true,
          onChanged: (bool? value) {},
        ),
      ),
    );
  }

  @override

  void initState(){
    super.initState();
    _updateTaskList();
  }

  _updateTaskList(){
    setState(() {
      _taskList = DataBaseHelper.instance.getTaskList();
    });
  }
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
        child:  Icon(Icons.add),
      ),
      body: Container(
        color: Colors.yellow,
        child: FutureBuilder(
          future: _taskList,
          builder: (context,AsyncSnapshot snapshot){
            return ListView.builder(

                itemCount: snapshot.data.length + 1,
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
                    return _builItem(snapshot.data[index-1]);
                });
          },

        ),
      ),
    );
  }
}