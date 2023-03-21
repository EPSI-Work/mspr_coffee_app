import 'package:flutter/material.dart';
import 'package:mspr_coffee_app/presentation/feature/product/view/product_view.dart';

class ProductScreen extends StatelessWidget {
  final String id;
  const ProductScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return const ProductView();
  }
}
