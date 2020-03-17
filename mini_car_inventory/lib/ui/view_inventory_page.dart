import 'package:flutter/material.dart';
import 'package:mini_car_inventory/bloc/model_bloc.dart';
import 'package:mini_car_inventory/constants/constant.dart';
import 'package:mini_car_inventory/model/model.dart';
import 'package:mini_car_inventory/repository/model_repository.dart';
import 'package:mini_car_inventory/ui/add_model_page.dart';
import 'package:mini_car_inventory/ui/main_drawer.dart';

class ViewInventoryPage extends StatefulWidget {
  static String id = 'ViewInventoryPage';
  @override
  _ViewInventoryPageState createState() => _ViewInventoryPageState();
}

class _ViewInventoryPageState extends State<ViewInventoryPage> {
  ModelRepository modelRepository = ModelRepository();
  List<Model> modelsList = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geModels();
  }

  geModels() async {
    modelsList = await modelRepository.getAllModels();

    for (int i = 0; i < modelsList.length; i++) {
      print('Manufacturere new: ${modelsList[i].name}');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Inventory'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCarModelPage()),
              );
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
          : modelsList.length == 0
              ? Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'No any car is in the inventory. Please add Car.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                      ),
                      SizedBox(height: 15.0,),
                      FlatButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          print('new');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCarModelPage()),
                          );
                        },
                        child: Text(
                          'Add New Car',
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
                      itemCount: modelsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print(modelsList[index].name);

                            _settingModalBottomSheet(
                                context, modelsList[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('${modelsList[index].id}.', style: TextStyle(fontWeight: FontWeight.w600),),
                                Text('${modelsList[index].manufacturer_name}', style: TextStyle(fontWeight: FontWeight.w600),),
                                Text('${modelsList[index].name}', style: TextStyle(fontWeight: FontWeight.w600),),
                                Text('${modelsList[index].count}', style: TextStyle(fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
    );
  }

  void _settingModalBottomSheet(context, Model model) {
    ModelBloc modelBloc = ModelBloc();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height - 100.0,
              child: Column(
                children: <Widget>[
                  /*MODEL NAME*/ Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Model Name', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(model.name, style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Divider(),
                  /*MANUFACTURE YEAR*/  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Manufecturer Name', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(model.manufacturer_name,style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Divider(),
                  /*MODEL NAME*/  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Manufacture Year',style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(model.year,style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Divider(),
                  /*REG NO*/   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Reg No',style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(model.regno,style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Divider(),
                  /*COUNT*/ Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Model Available',style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('${model.count}',style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20.0,),
                  FlatButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      if (model.count == 1) {
                        // Delete if only one car is there

                        modelBloc.deleteModelById(model.id);
                      } else {
                        // If more that one car then update the count
                        int remainingCount = model.count - 1;
                        modelBloc.updateModelCount(
                            model.id.toString(), remainingCount);
                      }

                      setState(() {
                        geModels();
                      });

                      Navigator.pop(context);

                    },
                    child: Text('Sold',style: kButtonTextStyle,),
                  )
                ],
              ),);
        });
  }
}
