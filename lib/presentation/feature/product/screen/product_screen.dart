import 'package:flutter/material.dart';
import 'package:mspr_coffee_app/presentation/feature/product/view/product_view.dart';

class ProductScreen extends StatelessWidget {
  final String id;
  final String image;
  const ProductScreen({
    super.key,
    required this.id,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ProductView(
      image: image,
    );
  }
}
