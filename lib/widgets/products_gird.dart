import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/providers/products_provider.dart';
import 'package:quick_pick/widgets/product_display_item.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavorites;
  ProductsGrid(this.showFavorites);

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final loadedProducts =
        widget.showFavorites ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: ProductDisplayItem(),
        );
      },
      itemCount: loadedProducts.length,
    );
  }
}
