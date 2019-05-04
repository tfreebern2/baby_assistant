import 'dart:io';
import 'dart:async';

import 'package:baby_assistant/model/ate_activity.dart';
import 'package:baby_assistant/model/change_activity.dart';
import 'package:baby_assistant/model/child.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/util/date_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String columnId = "id";

  // Child
  final String columnChildId = "childId";
  final String columnFirstName = "first_name";
  final String columnBirthdate = "birthdate";

  // Tables
  final String tableChild = "childTable";
  final String tableDrinkActivity = "drinkActivityTable";
  final String tableAteActivity = "ateActivityTable";
  final String tableChangeActivity = "changeActivityTable";

  // Generics
  final String columnDate = "date";
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
        "baby1c.db"); //home://directory/files/notodo_db.db
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableChild(id INTEGER PRIMARY KEY, $columnFirstName TEXT)");
    await db.execute(
        "CREATE TABLE $tableDrinkActivity(id INTEGER PRIMARY KEY, $columnChildId REFERENCES child (id), $columnDate TEXT, "
        "$columnStartTime TEXT, $columnEndTime TEXT, $columnDescription TEXT, $columnAmount TEXT, "
        "$columnUnit TEXT)");
    await db.execute(
        "CREATE TABLE $tableAteActivity(id INTEGER PRIMARY KEY, $columnChildId REFERENCES child (id), $columnDate TEXT, "
        "$columnStartTime TEXT, $columnEndTime TEXT, $columnDescription TEXT, $columnAmount TEXT)");
    await db.execute(""
        "CREATE TABLE $tableChangeActivity(id INTEGER PRIMARY KEY, $columnChildId REFERENCES child (id), $columnDate TEXT, "
        "$columnStartTime TEXT, $columnEndTime TEXT, $columnDescription TEXT");
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
    var result =
        await dbClient.insert("$tableDrinkActivity", drinkActivity.toMap());
    return result;
  }

  Future<ChangeActivity> getDrinkActivity(int id, int childId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableDrinkActivity WHERE $columnId = $id AND $columnChildId = $childId");

    if (result.length == 0) return null;
    return ChangeActivity.fromMap(result.first);
  }

  Future<List> getCurrentDrinkActivities(int childId) async {
    var dbClient = await db;
    String currentDate = dateNowFormattedForDb();
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableDrinkActivity WHERE $columnChildId = $childId AND $columnDate = $currentDate");
    return result.toList();
  }

  Future<int> deleteDrinkActivity(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableDrinkActivity, where: "$columnId = ?", whereArgs: [id]);
  }

  // Ate Activity
  Future<int> saveAteActivity(AteActivity ateActivity) async {
    var dbClient = await db;
    var result =
        await dbClient.insert("$tableAteActivity", ateActivity.toMap());
    return result;
  }

  Future<AteActivity> getAteActivity(int id, int childId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableAteActivity WHERE $columnId = $id AND $columnChildId = $childId");
    if (result.length == 0) return null;
    return AteActivity.fromMap(result.first);
  }

  Future<List> getCurrentAteActivities(int childId) async {
    var dbClient = await db;
    String currentDate = dateNowFormattedForDb();
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableAteActivity WHERE $columnChildId = $childId AND $columnDate = $currentDate");
    return result.toList();
  }

  Future<int> deleteAteActivity(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableAteActivity, where: "$columnId = ?", whereArgs: [id]);
  }

  // Change Activity
  Future<int> saveChangeActivity(ChangeActivity changeActivity) async {
    var dbClient = await db;
    var result =
        await dbClient.insert("$tableChangeActivity", changeActivity.toMap());
    return result;
  }

  Future<ChangeActivity> getChangeActivity(int id, int childId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableChangeActivity WHERE $columnId = $id AND $columnChildId = $childId");
    if (result.length == 0) return null;
    return ChangeActivity.fromMap(result.first);
  }

  Future<List> getCurrentChangeActivities(int childId) async {
    var dbClient = await db;
    String currentDate = dateNowFormattedForDb();
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableChangeActivity WHERE $columnChildId = $childId AND $columnDate = $currentDate");
    return result.toList();
  }

  Future<int> deleteChangeActivity(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableChangeActivity, where: "$columnId = ?", whereArgs: [id]);
  }

  // Close DB Client
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
