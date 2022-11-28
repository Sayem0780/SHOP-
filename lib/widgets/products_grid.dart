import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/main.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  bool showfavs = false;
  bool showcart = false;
  ProductsGrid(this.showfavs,this.showcart);

  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =  showfavs == true?productsData.favoriteItem:productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
