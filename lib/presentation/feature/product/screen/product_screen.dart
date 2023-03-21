import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/product_bloc/product_bloc.dart';
import 'package:mspr_coffee_app/presentation/feature/product/view/product_view.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  final String image;
  const ProductScreen({
    super.key,
    required this.id,
    required this.image,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(ProductFetchOne(id: widget.id)),
      child: ProductView(
        image: widget.image,
      ),
    );
  }
}
