import 'package:flutter/material.dart';
import 'package:shop/providers/products.dart';
import '../screens/edit_product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
class UserProduct extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  UserProduct(this.id,this.title,this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl),),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(EditProduct.routeName,arguments: id);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,),
            IconButton(
              onPressed: (){
                Provider.of<Products>(context,listen: false).deleteProduct(id);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,),
          ],
        ),
      ),
    );
  }
}
