import 'package:flutter/material.dart';
import 'package:quick_pick/providers/cart.dart';
import 'package:quick_pick/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:quick_pick/screens/product_details_screen.dart';

class ProductDisplayItem extends StatelessWidget {
  // final Product product;
  // ProductDisplayItem(this.product);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GridTile(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.contain,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (ctx, product, child) => IconButton(
                  color: Theme.of(context).accentColor,
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    product.toggleFavotireStatus();
                  },
                ),
              ),
              trailing: IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(Icons.shopping_bag),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                },
              ),
              title: Text(
                product.title,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
