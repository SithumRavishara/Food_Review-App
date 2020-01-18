import 'package:first_app/scoped-models/main.dart';
import 'package:flutter/material.dart';
import './product_card.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget productcards;
    if (products.length > 0) {
      productcards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productcards = Container();
    }
    return productcards;
  }

  @override
  Widget build(BuildContext context) {
    print('[products widget] build');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductList(model.displayedProducts);
      },
    );
  }
}
