import 'package:mspr_coffee_app/presentation/feature/home/view/home_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int index;
  const HomeScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeView(
      index: index,
    );
  }
}
