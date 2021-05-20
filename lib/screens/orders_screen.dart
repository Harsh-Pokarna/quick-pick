import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/providers/orders.dart';
import 'package:quick_pick/widgets/app_drawer.dart';
import 'package:quick_pick/widgets/order_item.dart';

class OrdersSreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrdersSreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return EachOrderDisplay(ordersData.orders[index]);
        },
        itemCount: ordersData.orders.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
