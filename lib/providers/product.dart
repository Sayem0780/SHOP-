import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  bool iscart;


  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.iscart = false,
  });

  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
  void toggleCartStatus(){
    iscart = !iscart;
    notifyListeners();
  }
}
