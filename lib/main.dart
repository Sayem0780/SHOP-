import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/screens/cart_screen.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider( providers: [
      ChangeNotifierProvider(
        create: (ctx) => Products(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => Cart(),
      ),
      ChangeNotifierProvider(create:(ctx)=> Orders())
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData.light().copyWith(
              accentColor: Colors.purple,
              primaryColor: Colors.deepOrange,
              textSelectionColor: Colors.black87,
              textSelectionHandleColor: Colors.cyan,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.pink,
              selectionColor: Colors.green,
              selectionHandleColor: Colors.blue,
            )
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName:(ctx) => CartScreen(),
            OrdersScreen.routeName:(ctx) => OrdersScreen(),
            UserProductScreen.routeName:(ctx) => UserProductScreen(),
            EditProduct.routeName:(ctx) => EditProduct(),
          }),
    );

  }
}
