import 'package:flutter/material.dart';
import 'package:quick_pick/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://www.7camicie.com/17998-big_default/trousers-chinos-premium-quality-dark-green-5793.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Cool Hoody',
      description: 'A cool hoody from Fila',
      price: 29.99,
      imageUrl:
          'https://www.fila.de/out/pictures/master/product/1/fila_edison_hoody_white_6450282_1112.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Hat',
      description: 'Amazing Hat',
      price: 59.99,
      imageUrl:
          'https://manofmany.com/wp-content/uploads/2017/10/Guide-to-Wearing-Mens-Hats-With-Suits-Fedora-Hat-1.jpg',
    ),
  ];

  // var _showFavoritesonly = false;
  List<Product> get items {
    // if (_showFavoritesonly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    _items[prodIndex] = newProduct;
    notifyListeners();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesonly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesonly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
