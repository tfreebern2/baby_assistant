import 'dart:io';
import 'dart:async';

import 'package:baby_assistant/model/child.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String childTable = "childTable";
  final String columnId = "id";
  final String columnFirstName = "firstName";
  final String columnDateOfBirth = "dateOfBirth";
  final String columnRoutine = "routine";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();

    return _db;
  }

  DatabaseHelper.internal();

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "child_db.db"); //home://directory/files/notodo_db.db

    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $childTable(id INTEGER PRIMARY KEY, $columnFirstName TEXT, $columnDateOfBirth TEXT)");
  }

  // CRUD
  // Insert
  Future<int> saveItem(Child child) async {
    var dbClient = await db;
    int result = await dbClient.insert("$childTable", child.toMap());
    return result;
  }

  // Get Items
  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $childTable ORDER BY $columnFirstName ASC");
    return result.toList();
  }

  // Get Count of Items
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $childTable"));
  }

  // Get Item
  Future<Child> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $childTable WHERE $columnId = $id");

    if (result.length == 0) return null;
    return Child.fromMap(result.first);
  }

  // Delete Item
  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(childTable, where: "$columnId = ?", whereArgs: [id]);
  }

  // Update Item
  Future<int> updateItem(Child child) async {
    var dbClient = await db;
    return await dbClient.update(childTable, child.toMap(),
        where: "$columnId =?", whereArgs: [child.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}