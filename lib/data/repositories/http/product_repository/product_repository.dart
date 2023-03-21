import 'package:mspr_coffee_app/data/responses/http_success_response.dart';
import 'package:mspr_coffee_app/data/services/http/http_auth_service.dart';
import 'package:mspr_coffee_app/data/models/models.dart';
import 'package:mspr_coffee_app/data/services/http/http_erp_service.dart';

class ProductRepository extends HttpErpService {
  final String endpoint = '/products';

  ProductRepository({required super.authorizationToken});
  Future<HttpSuccessResponse<Product>> fetchOne({
    required String id,
  }) async {
    return await get(
      endpoint: 'endpoint/$id',
    ).then((value) => HttpSuccessResponse<Product>(value.statusCode,
        content: Product.fromJson(value.content)));
  }

  Future<HttpSuccessResponse<List<Product>>> fetchAll() async {
    return await get(
      endpoint: endpoint,
    ).then((value) => HttpSuccessResponse<List<Product>>(value.statusCode,
        content:
            (value.content as List).map((e) => Product.fromJson(e)).toList()));
  }
}
