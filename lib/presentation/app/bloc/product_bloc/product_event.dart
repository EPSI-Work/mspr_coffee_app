part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent([List props = const []]);

  @override
  List<Object?> get props => [];
}

class ProductFetchAll extends ProductEvent {
  final String? page;
  final String? size;

  ProductFetchAll({this.page, this.size});

  @override
  List<Object?> get props => [page, size];
}

class ProductFetchOne extends ProductEvent {
  final String id;

  ProductFetchOne({required this.id});

  @override
  List<Object> get props => [id];
}

class ProductSelect extends ProductEvent {
  final Product product;

  ProductSelect({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductReset extends ProductEvent {}
