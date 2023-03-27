import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mspr_coffee_app/domain/entities/entity.dart';
import 'package:mspr_coffee_app/presentation/app/app_route.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/product_bloc/product_bloc.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/images/coffee1.png',
      'assets/images/coffee2.png',
      'assets/images/coffee3.png',
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu_rounded),
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
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4),
                      child: Text('Morning begins with PayeTonKawa',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.start),
                    ),
                  ),
                  //SearchBar widget
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.filter_list),
                            //border grey color
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 213, 213, 213),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state.status == ProductStatus.failure) {
                    return Center(child: Text('failed to fetch products'));
                  }
                  if (state.status == ProductStatus.success) {
                    if (state.products.isEmpty) {
                      return Center(child: Text('no products'));
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          Product currentProduct = state.products[index];
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoute.product.name,
                                  params: {'id': currentProduct.id!},
                                  queryParams: {'image': images[index % 3]});
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 20),
                                height: 100,
                                width: 192,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(3, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF7AA79D),
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Image.asset(
                                              images[index % 3],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, left: 16, right: 16),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentProduct.name ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              currentProduct.subtitle ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              textAlign: TextAlign.start,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  (currentProduct.details !=
                                                          null)
                                                      ? '${currentProduct.details!.price} €'
                                                      : '0 €',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  textAlign: TextAlign.start,
                                                ),
                                                Container(
                                                  height: 36,
                                                  width: 36,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEB8D59),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        spreadRadius: 3,
                                                        blurRadius: 12,
                                                        offset:
                                                            const Offset(3, 6),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Icon(Icons.add,
                                                        color: Colors.white,
                                                        size: 28),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]),
                                    )
                                  ],
                                )),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('Popular',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.black)),
                  ),
                ),
                BlocProvider(
                  create: (context) => ProductBloc()..add(ProductFetchAll()),
                  child: Expanded(
                    flex: 3,
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              Product currentProduct = state.products[index];
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed(AppRoute.product.name,
                                      params: {
                                        'id': currentProduct.id!
                                      },
                                      queryParams: {
                                        'image': images[index % 3]
                                      });
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 14),
                                    width: 260,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: const Offset(3, 5),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 64,
                                            width: 64,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF7AA79D),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: Image.asset(
                                                  images[index % 3],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    currentProduct.name ?? '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                    softWrap: true,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        currentProduct
                                                                .subtitle ??
                                                            '',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      Text(
                                                        (currentProduct
                                                                    .details !=
                                                                null)
                                                            ? '${currentProduct.details!.price} €'
                                                            : '0 €',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ],
            ))
          ],
        ));
  }
}