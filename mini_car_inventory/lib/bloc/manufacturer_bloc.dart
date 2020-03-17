import 'package:mini_car_inventory/model/manufacturer.dart';
import 'package:mini_car_inventory/repository/manufacturer_repository.dart';


import 'dart:async';

class ManufacturerBloc {
  //Get instance of the Repository
  final _manufacturerRepository = ManufacturerRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _manufacturerController = StreamController<List<Manufacturer>>.broadcast();

  get manufacturers => _manufacturerController.stream;

  ManufacturerBloc() {
    getManufacturers();
  }

  getManufacturers() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event


    List<Manufacturer> manuList = await _manufacturerRepository.getAllManufacturer();
    _manufacturerController.sink.add(manuList);
    for(int i=0;i<manuList.length;i++){
      print('Manufacturere in bloc: ${manuList[i].name}');
    }


  }

  addManufacturer(Manufacturer manufacturer) async {
    await _manufacturerRepository.insertManufacturer(manufacturer);
    getManufacturers();
  }

  dispose() {
    _manufacturerController.close();
  }
}
