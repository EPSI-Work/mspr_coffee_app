import 'package:firebase_auth/firebase_auth.dart';
import 'package:mspr_coffee_app/domain/entities/entity.dart';
import 'package:mspr_coffee_app/data/repositories/http/product_repository/product_repository.dart'
    as data_product_repository;

class ProductRepository {
  data_product_repository.ProductRepository? _productRepository;

  Future<data_product_repository.ProductRepository>
      _getProductRepository() async {
    if (_productRepository == null) {
      final currentUser = FirebaseAuth.instance.currentUser;
      final token = await currentUser!.getIdToken();
      _productRepository =
          data_product_repository.ProductRepository(authorizationToken: token);
    }
    return _productRepository!;
  }

  Future<Product> getOne({required String id}) async {
    final productRepository = await _getProductRepository();
    return Product.fromDataModel(await productRepository
        .fetchOne(id: id)
        .then((value) => value.content));
  }

  Future<List<Product>> getAll({String? page, String? size}) async {
    final productRepository = await _getProductRepository();
    return Product.listFromMapData(await productRepository
        .fetchAll(
          page: page ?? '1',
          size: size ?? '6',
        )
        .then((value) => value.content));
  }
}
