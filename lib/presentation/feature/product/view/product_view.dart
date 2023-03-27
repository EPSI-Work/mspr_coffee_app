import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/product_bloc/product_bloc.dart';
import 'package:mspr_coffee_app/presentation/feature/product/widget/product_ar_widget.dart';

class ProductView extends StatelessWidget {
  final String image;
  const ProductView({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          actions: [
            Badge(
              label: Text('1',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              alignment: AlignmentDirectional.topStart,
              largeSize: 16,
              smallSize: 18,
              child: IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.status == ProductStatus.failure) {
              return Center(
                child: Text('Failed to load product'),
              );
            }

            if (state.status == ProductStatus.success) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7AA79D),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.product.name ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    softWrap: true,
                                    maxLines: 2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    (state.product.details != null)
                                        ? '${state.product.details!.price} €'
                                        : '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Details',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  state.product.details?.description ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total: ${(state.product.details != null) ? state.product.details!.price : 0} €',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Container(
                                  height: 42,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF1F4F4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: GestureDetector(
                                              child: Center(
                                                  child: Icon(Icons.remove,
                                                      color: Colors.black)))),
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                        "1",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                      ))),
                                      Expanded(
                                          child: GestureDetector(
                                              child: Center(
                                                  child: Icon(Icons.add,
                                                      color: Colors.black)))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 40, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFEB8D59),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Icon(Icons.shopping_cart_outlined,
                                  size: 30, color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomObjectPage(
                                            title: state.product.name ??
                                                "3D Object",
                                          )));
                            },
                            child: Container(
                                height: 70,
                                width: 260,
                                decoration: BoxDecoration(
                                  color: Color(0xFF7AA79D),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.view_in_ar,
                                        size: 30, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      'See it !',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                        ]),
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
