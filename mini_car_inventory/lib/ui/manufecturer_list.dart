import 'package:flutter/material.dart';
import 'package:mini_car_inventory/model/manufacturer.dart';
import 'package:mini_car_inventory/repository/manufacturer_repository.dart';

import 'add_manufacturer_page.dart';
import 'main_drawer.dart';

class ManufacturerListScreen extends StatefulWidget {
  static String id = 'ManufacturerListScreen';
  @override
  _ManufacturerListScreenState createState() => _ManufacturerListScreenState();
}

class _ManufacturerListScreenState extends State<ManufacturerListScreen> {
  ManufacturerRepository modelRepository = ManufacturerRepository();
  List<Manufacturer> manufacturerList = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geManufacturer();
  }

  geManufacturer() async {
    manufacturerList = await modelRepository.getAllManufacturer();

    for (int i = 0; i < manufacturerList.length; i++) {
      print('Manufacturere new: ${manufacturerList[i].name}');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manufacturers'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AddManufacturerPage()),
              ).then((value) {
                setState(() {
                  geManufacturer();
                });
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: isLoading
          ? Text('loading')
          : manufacturerList.length == 0
              ? Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No Manufacturer found. Please add Manufacturer.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      FlatButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          print('new');
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new AddManufacturerPage()),
                          ).then((value) {
                            setState(() {
                              geManufacturer();
                            });
                          });
                        },
                        child: Text(
                          'Add New Manufacturer',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: manufacturerList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${manufacturerList[index].name}', style: TextStyle(fontWeight: FontWeight.w600),),
                            ],
                          ),
                        );
                      }),
                ),
    );
  }
}
