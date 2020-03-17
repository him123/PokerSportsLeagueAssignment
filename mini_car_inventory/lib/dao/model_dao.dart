import 'dart:async';
import 'package:mini_car_inventory/database/database.dart';
import 'package:mini_car_inventory/model/model.dart';

class ModelDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Model records
  Future<int> createModel(Model Model) async {
    final db = await dbProvider.database;
    var result = db.insert(modelTABLE, Model.toDatabaseJson());
    return result;
  }

  //Get All Model items
  //Searches if query string was passed
  Future<List<Model>> getModels() async {
    final db = await dbProvider.database;
    var res = await db.query(modelTABLE);

    List<Model> modelList = res.isNotEmpty
        ? res.map((c) => Model.fromDatabaseJson(c)).toList()
        : [];

    return modelList;
  }

  //Update Model record
  Future<int> updateModel(Model Model) async {
    final db = await dbProvider.database;

    var result = await db.update(modelTABLE, Model.toDatabaseJson(),
        where: "id = ?", whereArgs: [Model.id]);

    return result;
  }

  updateCount(String id, int count) async {
    final db = await dbProvider.database;

    var raw = await db
        .rawUpdate('UPDATE model SET count = "$count" WHERE id = "$id"');
    return raw;
  }

  //Delete Model records
  Future<int> deleteModel(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(modelTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllModels() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      modelTABLE,
    );

    return result;
  }
}
