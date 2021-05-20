import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/providers/cart.dart';

class CardItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  CardItem({this.id, this.productId, this.price, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(productId);
      },
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 30),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('Rs$price')),
            ),
            title: Text(title),
            subtitle: Text(
              'Total: Rs${price * quantity}',
            ),
            trailing: Text(
              quantity.toString() + 'x',
            ),
          ),
        ),
      ),
    );
  }
}
