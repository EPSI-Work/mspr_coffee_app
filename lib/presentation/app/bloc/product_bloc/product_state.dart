part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  success,
  failure,
  inProgress,
  select,
}

extension ProductStatusX on ProductStatus {
  bool get initial => this == ProductStatus.initial;
  bool get success => this == ProductStatus.success;
  bool get failure => this == ProductStatus.failure;
  bool get inProgress => this == ProductStatus.inProgress;
  bool get select => this == ProductStatus.select;
}

class ProductState extends Equatable {
  const ProductState(
      {this.status = ProductStatus.initial,
      this.message = '',
      List<Product>? products,
      Product? product})
      : products = products ?? const [],
        product = product ?? Product.empty;

  final ProductStatus status;
  final String message;
  final List<Product> products;
  final Product product;

  @override
  List<Object> get props => [status, message];

  ProductState copyWith(
      {ProductStatus? status,
      String? message,
      List<Product>? products,
      Product? product}) {
    return ProductState(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products,
      product: product ?? this.product,
    );
  }
}
