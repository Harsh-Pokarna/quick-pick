import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  // final String productTitle;
  // ProductDetailsScreen(this.productTitle);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final currentProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(currentProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              height: 300,
              child: Image.network(
                currentProduct.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(right: 40),
              child: Text(
                currentProduct.price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Text(
                currentProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
