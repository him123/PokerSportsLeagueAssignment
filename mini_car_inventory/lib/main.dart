import 'package:flutter/material.dart';
import 'package:mini_car_inventory/ui/add_manufacturer_page.dart';
import 'package:mini_car_inventory/ui/add_model_page.dart';
import 'package:mini_car_inventory/ui/manufecturer_list.dart';
import 'package:mini_car_inventory/ui/view_inventory_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reactive Flutter',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          canvasColor: Colors.white
      ),
      //Our only screen/page we have
      home: ViewInventoryPage(),
      routes: {
        ViewInventoryPage.id: (context) => ViewInventoryPage(),
        ManufacturerListScreen.id: (context) => ManufacturerListScreen(),
        AddManufacturerPage.id: (context) => AddManufacturerPage(),
        AddCarModelPage.id: (context) => AddCarModelPage(),
      },
    );
  }
}

