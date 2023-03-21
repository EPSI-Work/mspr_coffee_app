import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/product_bloc/product_bloc.dart';
import 'package:mspr_coffee_app/presentation/feature/overview/view/overview_view.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(ProductFetchAll()),
      child: OverviewView(),
    );
  }
}
