import 'dart:io';
import 'dart:async';

import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableChild = "childTable";
  final String columnId = "id";
  final String columnFirstName = "first_name";
  final String columnBirthdate = "birthdate";
  final String columnChildId = "child_id";

  final String tableRoutine = "routineTable";
  final String columnDate = "date";
  final String columnAteActivityId = "ate_activity_id";
  final String columnDrinkActivityId = "drink_activity_id";
  final String columnNapActivityId = "nap_activity_id";
  final String columnChangeActivityId = "change_activity_id";

  final String tableDrinkActivity = "drinkActivityTable";

  // id
  // date
  final String columnStartTime = "start_time";
  final String columnEndTime = "end_time";
  final String columnDescription = "description";
  final String columnAmount = "amount";
  final String columnUnit = "unit";

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
    String path = join(documentDirectory.path,
        "baby4.db"); //home://directory/files/notodo_db.db

    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableChild(id INTEGER PRIMARY KEY, $columnFirstName TEXT)");
//    await db.execute(
//        "CREATE TABLE $tableRoutine(id INTEGER PRIMARY KEY, $columnChildId INTEGER, $columnDate TEXT, "
//        "$columnAteActivityId INTEGER, $columnDrinkActivityId INTEGER, "
//        "$columnNapActivityId INTEGER, $columnChangeActivityId INTEGER)");
    await db.execute(
        "CREATE TABLE $tableDrinkActivity(id INTEGER PRIMARY KEY, $columnDate TEXT, "
        "$columnStartTime TEXT, $columnEndTime TEXT, $columnDescription TEXT, $columnAmount TEXT, "
        "$columnUnit TEXT)");
  }

  // Child
  Future<int> saveChild(Child child) async {
    var dbClient = await db;
    int result = await dbClient.insert("$tableChild", child.toMap());
    return result;
  }

  Future<List> getChildren() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableChild ORDER BY $columnFirstName ASC");
    return result.toList();
  }

  Future<int> getChildCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableChild"));
  }

  Future<Child> getChild(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableChild WHERE $columnId = $id");

    if (result.length == 0) return null;
    return Child.fromMap(result.first);
  }

  Future<int> deleteChild(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableChild, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateChild(Child item) async {
    var dbClient = await db;
    return await dbClient.update(tableChild, item.toMap(),
        where: "$columnId =?", whereArgs: [item.id]);
  }

  // Drink Activity
  Future<int> saveDrinkActivity(DrinkActivity drinkActivity) async {
    var dbClient = await db;
    var result = await dbClient.insert("$tableDrinkActivity", drinkActivity.toMap());
    return result;
  }

  Future<DrinkActivity> getDrinkActivity(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableDrinkActivity WHERE $columnId = $id");

    if (result.length == 0) return null;
    return DrinkActivity.fromMap(result.first);
  }

  Future<List> getDrinkActivities() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableDrinkActivity ORDER BY $columnDate ASC");
    return result.toList();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
