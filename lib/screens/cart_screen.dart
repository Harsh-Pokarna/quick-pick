import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/providers/cart.dart' show Cart;
import 'package:quick_pick/providers/orders.dart';
import 'package:quick_pick/widgets/card_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    label: Text(
                      'Rs' + cart.totalAmount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clearCart();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CardItem(
                  id: cart.items.values.toList()[index].id,
                  productId: cart.items.keys.toList()[index],
                  price: cart.items.values.toList()[index].price,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantitiy,
                );
              },
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
