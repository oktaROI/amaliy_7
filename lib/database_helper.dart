import 'dart:io';

import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:amaliy7/task.dart';


class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper._intance();

  static Database? _db;

  DataBaseHelper._intance();

  String taskTable = "";
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database?> get db async => _db ??= await _initDb();

  get databaseFactoryIo => null;

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/todo_list.db";
    final todoListDb = await databaseFactoryIo.openDatabase(path,
        version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $taskTable('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colTitle TEXT, '
        '$colDate TEXT, '
        '$colPriority TEXT, '
        '$colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>?> getTaskMapList() async {
    Database? db = await this.db;
    // final List<Map<String, Object?>> result = await db?.query(taskTable);
    //return result;
    final List<Map<String, dynamic>>? result = await db?.query(taskTable);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>>? taskMapList = await getTaskMapList();

    final List<Task> taskList = [];
    taskMapList?.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    return taskList;
  }
}

