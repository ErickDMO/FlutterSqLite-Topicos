import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Task{
  String name;
  String direction;
  String phone;

  Task(
    this.name,
    this.direction,
    this.phone
  );

  Map<String, dynamic> toMap(){
    return{
      "name": name,
      "direction": direction,
      "phone": phone
    };
  }

  Task.fromMap(Map<String, dynamic> map){
    name = map['name'];
    direction = map['direction'];
    phone = map['phone'];
  }
}

class TaskDatabase{
  Database _db;
  initDB() async{
    _db = await openDatabase(
      'my_db.db',
      version: 1,
      onCreate:(Database db, int version){
        db.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY, name TEXT NOT NULL, direction TEXT NOT NULL, phone TEXT NOT NULL)");
      }
    );
  }

  insert(Task task) async {
    _db.insert("tasks", task.toMap());
  }

  Future<List<Task>>getAllTasks() async {
    List<Map<String, dynamic>> results = await _db.query("tasks");
    return results.map((map)=> Task.fromMap(map)).toList();
  }

}
