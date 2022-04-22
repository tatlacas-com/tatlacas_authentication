import 'package:tatlacas_flutter_oauth/app_auth_export.dart';

class OauthRepository {
  final FlutterAppAuth flutterAppAuth;
  final AuthorizationTokenRequest authorizationTokenRequest;

  OauthRepository({
    required this.flutterAppAuth,
    required this.authorizationTokenRequest,
  });

  Future<AuthorizationTokenResponse?> authenticate(
    dynamic authType, {
    required Map<String, String> additionalParameters,
  }) async {
    final AuthorizationTokenResponse? result =
        await flutterAppAuth.authorizeAndExchangeCode(
      tokenRequestFor(
        authType,
        additionalParameters: additionalParameters,
      ),
    );
    return result;
  }

  AuthorizationTokenRequest tokenRequestFor(
    dynamic authType, {
    required Map<String, dynamic> additionalParameters,
  }) =>
      authorizationTokenRequest;
}
