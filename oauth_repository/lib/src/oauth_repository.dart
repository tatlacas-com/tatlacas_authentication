import 'package:tatlacas_flutter_oauth/app_auth_export.dart';
import 'package:user_repository/user_repository.dart';

class OauthRepository {
  final FlutterAppAuth flutterAppAuth;
  final AuthorizationTokenRequest authorizationTokenRequest;

  OauthRepository({
    required this.flutterAppAuth,
    required this.authorizationTokenRequest,
  });

  Future<UserEntity?> authenticate() async {
    final token = await _authenticate();
    if (token != null) return UserEntity(id: 'testing 123');
    return null;
  }

  Future<String?> _authenticate() async {
    final AuthorizationTokenResponse? result =
        await flutterAppAuth.authorizeAndExchangeCode(
      authorizationTokenRequest,
    );
    return result?.accessToken;
  }
}
