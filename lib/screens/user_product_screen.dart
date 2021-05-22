import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/providers/products_provider.dart';
import 'package:quick_pick/screens/edit_product_screen.dart';
import 'package:quick_pick/widgets/app_drawer.dart';
import 'package:quick_pick/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products-screen';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        // height: 400,
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                imageUrl: productsData.items[index].imageUrl,
                title: productsData.items[index].title,
              ),
              Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
