import 'package:flutter/material.dart';
import 'package:mini_car_inventory/ui/add_model_page.dart';
import 'package:mini_car_inventory/ui/manufecturer_list.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
//    getNameAndImage();

    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
              'Welcome to Car Inventory',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
            decoration: new BoxDecoration(
              color: Colors.blue,
//              image: new DecorationImage(
//                image: new ExactAssetImage('images/logo.jpg'),
//                fit: BoxFit.cover,
//              ),
            ),
            currentAccountPicture: ClipOval(
              child: Image.asset(
                'images/default_user.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          buildListTile('Menufecturer', Icons.local_gas_station, () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManufacturerListScreen()),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.black,
              height: 1.0,
            ),
          ),
          buildListTile('Add Car Models', Icons.directions_car, () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCarModelPage()),
            );
          }),
        ],
      ),
    );
  }
}
