import 'package:flutter/material.dart';
import 'package:quick_pick/models/http_exception.dart';
import 'package:quick_pick/providers/auth.dart';
import 'package:quick_pick/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://www.7camicie.com/17998-big_default/trousers-chinos-premium-quality-dark-green-5793.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Cool Hoody',
    //   description: 'A cool hoody from Fila',
    //   price: 29.99,
    //   imageUrl:
    //       'https://www.fila.de/out/pictures/master/product/1/fila_edison_hoody_white_6450282_1112.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Hat',
    //   description: 'Amazing Hat',
    //   price: 59.99,
    //   imageUrl:
    //       'https://manofmany.com/wp-content/uploads/2017/10/Guide-to-Wearing-Mens-Hats-With-Suits-Fedora-Hat-1.jpg',
    // ),
  ];

  // var _showFavoritesonly = false;
  List<Product> get items {
    // if (_showFavoritesonly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  // ProductsProvider(this.authToken, this._items);
  Future<String> get myAuthToken async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('authToken');
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://quick-pick-947bd-default-rtdb.firebaseio.com/products.json?auth=${await myAuthToken}';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
    // print(json.decode(response.body));
  }

  Future<void> removeProduct(String id) async {
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    final url =
        'https://quick-pick-947bd-default-rtdb.firebaseio.com/products/$id.json';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Unable to delete product').toString();
    }
    existingProduct = null;
  }

  Future<void> fetchAndSetProducts() async {
    final url =
        'https://quick-pick-947bd-default-rtdb.firebaseio.com/products.json?auth=${await myAuthToken}';
    try {
      final response = await http.get(Uri.parse(url));
      final List<Product> loadedProducts = [];
      final extratedData = json.decode(response.body) as Map<String, dynamic>;
      extratedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
        ));
        _items = loadedProducts;
        notifyListeners();
      });
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    final url =
        'https://quick-pick-947bd-default-rtdb.firebaseio.com/products/$id.json';
    await http.patch(Uri.parse(url),
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
        }));
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
