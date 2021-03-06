import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantitiy;
  final double price;
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantitiy,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.quantitiy;
      },
    );
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantitiy: existingCartItem.quantitiy + 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantitiy: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeLastItem(String id) {
    if (_items[id].quantitiy > 1) {
      _items.update(id, (existingProduct) {
        return CartItem(
          id: existingProduct.id,
          title: existingProduct.title,
          quantitiy: existingProduct.quantitiy - 1,
          price: existingProduct.price,
        );
      });
    }
    if (_items[id].quantitiy == 1) {
      _items.remove(id);
      notifyListeners();
    } else {
      return;
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
