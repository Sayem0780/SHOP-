import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String ProductId;
  final String title;
  final double price;
  final int quantity;
  CartItem(this.id,this.ProductId, this.title,this.price,this.quantity);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (context)=>
            AlertDialog(
          title: Text("Are You Sure"),
          content: Text("DO you want to remove the item"),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop(false);
            }, child: Text("No")),
            FlatButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child: Text("Yes"))
          ],
        ));
      },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(ProductId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
        child: ListTile(
          leading: FittedBox(child: CircleAvatar(
            maxRadius: 35,
            child: Padding(padding: const EdgeInsets.all(5.0), child: Text("\$ $price"),),)),
          title: Text(title),
          subtitle: Text("Total Price: \$${price*quantity}"),
          trailing: Text("$quantity x"),
        ),

      ),
    );
  }
}
