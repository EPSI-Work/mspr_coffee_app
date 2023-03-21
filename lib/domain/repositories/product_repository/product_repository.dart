import 'package:firebase_auth/firebase_auth.dart';
import 'package:mspr_coffee_app/domain/entities/entity.dart';
import 'package:mspr_coffee_app/data/repositories/http/product_repository/product_repository.dart'
    as data_product_repository;

class ProductRepository {
  final data_product_repository.ProductRepository _productRepository =
      data_product_repository.ProductRepository(
          authorizationToken:
              FirebaseAuth.instance.currentUser!.getIdToken().toString());

  Future<Product> getOne({required String id}) async {
    return Product.fromDataModel(await _productRepository
        .fetchOne(id: id)
        .then((value) => value.content));
  }

  Future<List<Product>> getAll() async {
    return Product.listFromMapData(
        await _productRepository.fetchAll().then((value) => value.content));
  }
}
