import 'package:flutter/material.dart';
import 'package:quick_pick/providers/auth.dart';
import 'package:quick_pick/providers/cart.dart';
import 'package:quick_pick/providers/orders.dart';
import 'package:quick_pick/screens/4.1%20auth_screen.dart';
import 'package:quick_pick/screens/cart_screen.dart';
import 'package:quick_pick/screens/edit_product_screen.dart';
import 'package:quick_pick/screens/orders_screen.dart';
import 'package:quick_pick/screens/product_details_screen.dart';
import 'package:quick_pick/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/screens/user_product_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProvider.value(value: Orders()),
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: ProductsProvider()),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'WorkSans',
                ),
                home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
                routes: {
                  ProductDetailsScreen.routeName: (context) =>
                      ProductDetailsScreen(),
                  // CartScreen.routeName: (context) => CartScreen(),
                  // CartScreen.routeName: (context) => CartScreen(),
                  CartScreen.routeName: (con) => CartScreen(),
                  AuthScreen.routeName: (con) => AuthScreen(),
                  OrdersSreen.routeName: (con) => OrdersSreen(),
                  UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                  EditProductScreen.routeName: (ctx) => EditProductScreen(),
                });
          },
        ));
  }
}
