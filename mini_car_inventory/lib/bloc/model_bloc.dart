import 'package:mini_car_inventory/model/model.dart';
import 'package:mini_car_inventory/repository/model_repository.dart';

import 'dart:async';

class ModelBloc {
  //Get instance of the Repository
  final _modelRepository = ModelRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _modelController = StreamController<List<Model>>.broadcast();

  get models => _modelController.stream;

  ModelBloc() {
    getModels();
  }

  getModels() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _modelController.sink.add(await _modelRepository.getAllModels());
  }

  addModel(Model model) async {
    await _modelRepository.insertModel(model);
    getModels();
  }

  updateModel(Model model) async {
    await _modelRepository.updateModel(model);
    getModels();
  }

  updateModelCount(String id, int count) async {
    await _modelRepository.updateCount(id, count);
    getModels();
  }

  deleteModelById(int id) async {
    _modelRepository.deleteModelById(id);
    getModels();
  }

  dispose() {
    _modelController.close();
  }
}
