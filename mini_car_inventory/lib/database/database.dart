import 'dart:async';
import 'dart:io';

import 'package:mini_car_inventory/model/manufacturer.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final manuFacturerTABLE = 'Manufacturer';
final modelTABLE = 'Model';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"CarInventory.db is our database instance name
    String path = join(documentsDirectory.path, "CarInventory.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $manuFacturerTABLE ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT"
        ")");

    await database.execute("CREATE TABLE $modelTABLE ("
        "id INTEGER PRIMARY KEY, "
        "manufacturer_name TEXT,"
        "name TEXT,"
        "year TEXT,"
        "color TEXT,"
        "regno TEXT,"
        "note TEXT,"
        "count INTEGER,"
        "pic TEXT"
        ")");
  }
}
