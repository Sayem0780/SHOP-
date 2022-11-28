import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import '../screens/drawer.dart';
import '../widgets/user_product.dart';
import '../screens/edit_product.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userproductscreen';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Your Product"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, EditProduct.routeName);
          }, icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
            itemBuilder: (_,i)=> UserProduct(
                productsData.items[i].id,
                productsData.items[i].title,
                productsData.items[i].imageUrl)),
      ),
    );
  }
}
