import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  /*final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);*/

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(//ClipRRect mean Clip the Rectangle shape in Round Shape.
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder:(context,product,child)=> IconButton(
              icon: product.isFavorite?Icon(Icons.favorite):Icon(Icons.favorite_border_outlined),
              color: Theme.of(context).errorColor,
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: product.iscart?Icon(Icons.shopping_cart,) :Icon(Icons.shopping_cart_outlined,),
            onPressed: () {
              product.toggleCartStatus();
              cart.addItem(product.id, product.price, product.title);
              //Scaffold.of(context).openDrawer();
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Add Item",textAlign: TextAlign.center,),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: (){
                      cart.removeSingleItem(product.id);
                    },
                  ),
                  ));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
