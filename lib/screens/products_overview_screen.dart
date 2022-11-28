import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/drawer.dart';
import 'package:shop/widgets/badge.dart';

import '../widgets/products_grid.dart';

enum FilterOptions{
  isFavorite,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  bool _showOnlyFavorite = false;
  bool _showCart = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedvalue){
              setState((){
                if(selectedvalue == FilterOptions.isFavorite){
                  _showOnlyFavorite = true;
                }else(_showOnlyFavorite = false);
              });
            },
            icon: Icon(Icons.more_vert),
              itemBuilder: (_)=>[
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.isFavorite,
                  ),
            PopupMenuItem(
              child: Text('Show All'),
              value: FilterOptions.all,
            ),
              ]

          ),
          Consumer<Cart>(builder: (_,cartdata,_2)=>Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: (){
                  Navigator.pushNamed(context, CartScreen.routeName);
                },),
              value: cartdata.itemCount.toString(),
              color: Theme.of(context).errorColor)
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorite,_showCart),
    );
  }
}
