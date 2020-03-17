import 'dart:async';
import 'package:mini_car_inventory/database/database.dart';
import 'package:mini_car_inventory/model/manufacturer.dart';

class ManufacturerDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Manufacturer records
  Future<int> createManufacturer(Manufacturer manufacturer) async {
    final db = await dbProvider.database;
    var result = db.insert(manuFacturerTABLE, manufacturer.toDatabaseJson());

    print('manufacturer added status ${result.toString()}');

    return result;
  }

  //Get All Manufacturers
  //Searches if query string was passed
  Future<List<Manufacturer>> getManufacturers() async {
    final db = await dbProvider.database;
    var res = await db.query(manuFacturerTABLE);
    List<Manufacturer> menuList = res.isNotEmpty
        ? res.map((c) => Manufacturer.fromDatabaseJson(c)).toList()
        : [];
    return menuList;
  }
}
