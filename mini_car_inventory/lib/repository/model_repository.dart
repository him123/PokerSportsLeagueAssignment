import 'package:mini_car_inventory/dao/model_dao.dart';
import 'package:mini_car_inventory/model/model.dart';

class ModelRepository {
  final modelDao = ModelDao();

  Future getAllModels({String query}) => modelDao.getModels();

  Future insertModel(Model model) => modelDao.createModel(model);

  Future updateModel(Model model) => modelDao.updateModel(model);

  Future updateCount(String id, int count) => modelDao.updateCount(id, count);

  Future deleteModelById(int id) => modelDao.deleteModel(id);

}
