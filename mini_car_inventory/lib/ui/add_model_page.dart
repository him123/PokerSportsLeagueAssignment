import 'package:flutter/material.dart';
import 'package:mini_car_inventory/bloc/model_bloc.dart';
import 'package:mini_car_inventory/constants/constant.dart';
import 'package:mini_car_inventory/model/manufacturer.dart';
import 'package:mini_car_inventory/model/model.dart';
import 'package:mini_car_inventory/repository/manufacturer_repository.dart';
import 'package:mini_car_inventory/ui/add_manufacturer_page.dart';
import 'package:mini_car_inventory/ui/view_inventory_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class AddCarModelPage extends StatefulWidget {
  static String id = 'AddCarModelPage';

  @override
  _AddCarModelPageState createState() => _AddCarModelPageState();
}

class _AddCarModelPageState extends State<AddCarModelPage> {
  String selectedManufacturer = '';
  ManufacturerRepository manufacturerRepository = ManufacturerRepository();
  List<String> listName = [];
  String modelName = '',
      color = '',
      manYear = '',
      regNo = '',
      note = '';
  int count = 0;
  ModelBloc modelBloc = ModelBloc();
  bool isLoading = true;

  getManufacturers() async {
    List<Manufacturer> menuList =
    await manufacturerRepository.getAllManufacturer();

    for (int i = 0; i < menuList.length; i++) {
      print('Manufacturere new: ${menuList[i].name}');
      listName.add(menuList[i].name);
    }

    if (listName.length > 0) {
      selectedManufacturer = listName[0];
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getManufacturers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car Model'),
      ),
      body: isLoading
          ? Center(child: Text('Loading Screen'))
          : listName.length == 0
          ? Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No any Manufacturer is in the inventory. Please add Manufacturer.',
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
                    getManufacturers();
                  });
                });
              },
              child: Text(
                'Add New Manufacturer',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 150,
                    child: TextField(
                      onChanged: (val) {
                        modelName = val;
                      },
                      textAlign: TextAlign.start,
                      decoration: kTextFieldInputDecoration,
                    ),
                  ),
                  Container(
                    child: DropdownButton(
                      value: selectedManufacturer,
                      items: listName.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (val) {
                        print(val);
                        setState(() {
                          selectedManufacturer = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              /*COLOR*/ TextField(
                onChanged: (val) {
                  color = val;
                },
                textAlign: TextAlign.start,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Color',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              /*Manufacturing Year*/ TextField(
                onChanged: (val) {
                  manYear = val;
                },
                textAlign: TextAlign.start,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Manufacturing Year',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              /*Reg number*/ TextField(
                onChanged: (val) {
                  regNo = val;
                },
                textAlign: TextAlign.start,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Reg number',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              /*COUNT*/ TextField(
                  onChanged: (val) {
                    count = int.parse(val);
                  },
                  textAlign: TextAlign.start,
                  decoration: kTextFieldInputDecoration.copyWith(
                    hintText: 'Count',
                  ),
                  keyboardType: TextInputType.number),
              SizedBox(
                height: 10.0,
              ),
              /*NOTE*/ TextField(
                onChanged: (val) {
                  note = val;
                },
                textAlign: TextAlign.start,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'note',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                color: Colors.redAccent,
                onPressed: () {
                  if (modelName == '') {
                    Toast.show('Please enter model name', context, gravity: Toast.CENTER);
                  } else if (color == '') {
                    Toast.show('Please enter color', context, gravity: Toast.CENTER);
                  } else if (manYear == '') {
                    Toast.show('Please enter manufacture year', context, gravity: Toast.CENTER);
                  } else if (regNo == '') {
                    Toast.show('Please enter reg no', context, gravity: Toast.CENTER);
                  } else if (count <= 0) {
                    Toast.show('Please enter count', context, gravity: Toast.CENTER);
                  } else {
                    final newManufacturer = Model(
                        name: modelName,
                        color: color,
                        manufacturer_name: selectedManufacturer,
                        note: note,
                        regno: regNo,
                        count: count,
                        year: manYear,
                        pic: 'pic');

                    modelBloc.addModel(newManufacturer);

                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: 'Model Added.',
                      buttons: [
                        DialogButton(
                          child: Text(
                            "OK",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewInventoryPage()),
                            );
                          },
                          width: 120,
                          color: Colors.lightBlue,
                          radius: BorderRadius.circular(5.0),
                        )
                      ],
                    ).show();
                  }
                },
                child: Text('Submit', style: kButtonTextStyle,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
