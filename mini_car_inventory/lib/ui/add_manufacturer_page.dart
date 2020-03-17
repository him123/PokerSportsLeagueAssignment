import 'package:flutter/material.dart';
import 'package:mini_car_inventory/bloc/manufacturer_bloc.dart';
import 'package:mini_car_inventory/constants/constant.dart';
import 'package:mini_car_inventory/model/manufacturer.dart';
import 'package:toast/toast.dart';

class AddManufacturerPage extends StatefulWidget {
  static String id = 'AddManufacturerPage';

  @override
  _AddManufacturerPageState createState() => _AddManufacturerPageState();
}

class _AddManufacturerPageState extends State<AddManufacturerPage> {
  String name='';
  final ManufacturerBloc manufacturerBloc = ManufacturerBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Manufacurer'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) {
                name = val;
              },
              textAlign: TextAlign.start,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(7.0),
                    ),
                  ),
                  filled: true,
                  hintText: 'Add Manufacturer',
                  fillColor: Colors.white70),
            ),
          ),
          FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              if (name == '') {

                Toast.show('Please enter name', context, gravity: Toast.CENTER);
              } else {
                final newManufacturer = Manufacturer(
                  name: name,

                );

                if (name.isNotEmpty) {
                  manufacturerBloc.addManufacturer(newManufacturer);
                  Navigator.pop(context, '1');
                }
              }
            },
            child: Text(
              'SUBMIT',
              style: kButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
