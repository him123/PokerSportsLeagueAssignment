import 'package:mini_car_inventory/dao/manufecturer_dao.dart';
import 'package:mini_car_inventory/model/manufacturer.dart';

class ManufacturerRepository {
  final manufacturerDao = ManufacturerDao();

  Future<List<Manufacturer>> getAllManufacturer() => manufacturerDao.getManufacturers();

  Future insertManufacturer(Manufacturer manufacturer) => manufacturerDao.createManufacturer(manufacturer);

}
