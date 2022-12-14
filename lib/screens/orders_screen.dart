import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/drawer.dart';
import '../providers/order.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
       itemBuilder:(ctx,i)=> OrderItem(order: orderData.orders[i]),
      )
    );
  }
}
