import 'dart:io';
import 'dart:async';

import 'package:baby_assistant/model/child.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  // DB TABLES
  // Child
  final String childTable = "childTable";
  final String childId = "id";
  final String columnFirstName = "first_name";
  final String columnDateOfBirth = "date_of_birth";
  final String columnRoutineId = "routine_id";

  // Routine
  final String routineTable = "routineTable";
  final String routineId = "id";
  final String columnDate = "date";
  final String columnAteStatusId = "ate_status_id";
  final String columnDrinkStatusId = "drink_status_id";
  final String columnNapStatusId = "nap_status_id";
  final String columnChangeStatusId = "change_status_id";

  // Ate Status
  final String ateTable = "ateTable";
  final String ateId = "id";
  final String columnDateAte = "date";
  final String columnStartTimeAte = "start_time";
  final String columnEndTimeAte = "end_time";
  final String columnAmountAte = "amount";
  final String columnUnitAte = "unit";
  final String columnTypeAte = "type";


  // Drink Activity
  final String drinkTable = "drinkTable";
  final String drinkId = "id";
  final String dateDrink = "date";
  final String startTimeDate = "start_time";
  final String endTimeDate = "end_time";
  final String descriptionDrink = "description";
  final String amountDrink = "amount";
  final String unitDrink = "unit";

  // Nap Activity
  final String napTable = "napTable";
  final String napId = "id";
  final String napDate = "date";
  final String startTimeNap = "start_time";
  final String endTimeNap = "end_time";
  final String length = "length";

  final String changeTable = "changeTable";
  final String changeId = "id";
  final String dateChange = "date";
  final String descriptionChange = "description";
  final String conditionChange = "condition";

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
        "babyassistant_db.db"); //home://directory/files/babyassistant_db.db

    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $childTable(id INTEGER PRIMARY KEY, $columnRoutineId INTEGER NOT NULL, "
            "$columnFirstName TEXT NOT NULL, $columnDateOfBirth TEXT NOT NULL, "
            "FOREIGN KEY (routine_id) REFERENCES routine (id) ON DELETE NO ACTION ON UPDATE NO ACTION )");
    await db.execute(
        "CREATE TABLE $routineTable(id INTEGER PRIMARY KEY, $columnDate INTEGER NOT NULL, "
            "$columnAteStatusId INTEGER NOT NULL, $columnDrinkStatusId INTEGER NOT NULL, "
            "$columnNapStatusId INTEGER NOT NULL, $columnNapStatusId INTEGER NOT NULL)");
    await db.execute("CREATE TABLE $ateTable(id INTEGER PRIMARY KEY, $columnDateAte TEXT NOT NULL, "
        "$columnStartTimeAte TEXT NOT NULL, $columnEndTimeAte TEXT NOT NULL, "
        "$columnAmountAte TEXT NOT NULL, $columnUnitAte TEXT NOT NULL, $columnTypeAte TEXT NOT NULL");
  }


  // CRUD
  // Insert
  Future<int> saveChild(Child child) async {
    var dbClient = await db;
    int result = await dbClient.insert("$childTable", child.toMap());
    return result;
  }

  // Get Items
  Future<List> getChildren() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $childTable ORDER BY $columnFirstName ASC");
    return result.toList();
  }

  // Get Count of Child
  Future<int> getChildCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $childTable"));
  }

  // Get Child
  Future<Child> getChild(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $childTable WHERE $childId = $id");

    if (result.length == 0) return null;
    return Child.fromMap(result.first);
  }

  // Delete Item
  Future<int> deleteChild(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(childTable, where: "$childId = ?", whereArgs: [id]);
  }

  // Update Item
  Future<int> updateChild(Child child) async {
    var dbClient = await db;
    return await dbClient.update(childTable, child.toMap(),
        where: "$childId =?", whereArgs: [child.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
