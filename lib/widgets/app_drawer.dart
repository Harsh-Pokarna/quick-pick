import 'package:flutter/material.dart';
import 'package:quick_pick/providers/orders.dart';
import 'package:quick_pick/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Hey There.'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.shop,
              ),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
              ),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersSreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
