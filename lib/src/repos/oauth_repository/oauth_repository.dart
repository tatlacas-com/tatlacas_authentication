import 'package:tatlacas_flutter_oauth/app_auth_export.dart';

class OauthRepository {
  final FlutterAppAuth flutterAppAuth;
  final AuthorizationTokenRequest authorizationTokenRequest;

  OauthRepository({
    required this.flutterAppAuth,
    required this.authorizationTokenRequest,
  });

  Future<AuthorizationTokenResponse?> authenticate(dynamic authType) async {
    final AuthorizationTokenResponse? result =
        await flutterAppAuth.authorizeAndExchangeCode(
      tokenRequestFor(authType),
    );
    return result;
  }

  AuthorizationTokenRequest tokenRequestFor(dynamic authType) =>
      authorizationTokenRequest;
}
