import 'package:flutter/material.dart';
import 'package:shop/screens/orders_screen.dart';
import '../screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Shop As you Like"),
          ),
          Divider(),
          ListTile(
            leading:Icon(Icons.shop),
            title: Text("Shop"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            }
          ),
          Divider(),
          ListTile(
              leading:Icon(Icons.payment),
              title: Text("Order"),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              }
          ),
          Divider(),
          ListTile(
              leading:Icon(Icons.edit),
              title: Text("Manage Order"),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
              }
          ),
        ],
      ),
    );
  }
}
