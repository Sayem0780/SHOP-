import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';
import '../widgets/cart_item.dart' as ci;
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cart Screen"),),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Theme.of(context).canvasColor, child: Text("Total",style: TextStyle(fontSize: 20),),),
                  Spacer(),
                  Chip(label: Text("\$${cart.totalAmount}",style: TextStyle(color: Theme.of(context).canvasColor,),),backgroundColor: Theme.of(context).primaryColorDark,),
                  FlatButton(onPressed: (){
                    Provider.of<Orders>(context,listen: false).addOrder(
                        cart.items.values.toList(), cart.totalAmount);
                    cart.clear();
                  }, child: Text("ORDER NOW",),textColor: Theme.of(context).primaryColor,),
                ],
              ),
            ),
          ),
          Expanded(child:ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (context,i)=>ci.CartItem(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
              cart.items.values.toList()[i].title,
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].quantity,),) ),

    ])
    );
  }
}
