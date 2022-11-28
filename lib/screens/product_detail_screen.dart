import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatefulWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(context, listen: false,).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title,style:TextStyle(color: Colors.white),),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                        height: 300,
                        width: double.infinity,
                        child: Image.network(
                            loadedProduct.imageUrl,
                          fit: BoxFit.contain,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                    ),
              SizedBox(height: 20,),
              Container(
                child: Text("\$${loadedProduct.price}",style: TextStyle(fontSize: 30),),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                child: Text(
                    "${loadedProduct.description}",
                  style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold),
                  softWrap: true,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),

    );
  }
}
