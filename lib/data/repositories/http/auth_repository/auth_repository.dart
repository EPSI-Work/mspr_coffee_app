import 'package:mspr_coffee_app/data/responses/http_success_response.dart';
import 'package:mspr_coffee_app/data/services/http/http_auth_service.dart';

class AuthRepository extends HttpAuthService {
  Future<HttpSuccessResponse> signInWithEmail({
    required String email,
  }) async {
    return await post(
      endpoint: '/signInWithEmail',
      body: {
        'email': email,
      },
    );
  }
}
