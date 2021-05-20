import 'package:flutter/material.dart';
import 'package:quick_pick/providers/cart.dart';
import 'package:quick_pick/screens/cart_screen.dart';
import 'package:quick_pick/widgets/app_drawer.dart';
import 'package:quick_pick/widgets/badge.dart';
import '../widgets/products_gird.dart';
import 'package:quick_pick/widgets/products_gird.dart';
import 'package:provider/provider.dart';

enum filterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Pick'),
        actions: [
          PopupMenuButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == filterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text('Favorites'),
                  value: filterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show all'),
                  value: filterOptions.All,
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) {
              return Badge(child: ch, value: cartData.itemCount.toString());
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
      drawer: AppDrawer(),
    );
  }
}
