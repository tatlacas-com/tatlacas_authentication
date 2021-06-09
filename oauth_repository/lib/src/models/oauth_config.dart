import 'package:equatable/equatable.dart';

class OAuthConfig extends Equatable {
  final String clientId;
  final String redirectUrl;
  final String? issuer;
  final List<String>? scopes;

  OAuthConfig({
    required this.clientId,
    required this.redirectUrl,
    this.issuer,
    this.scopes,
  });

  @override
  List<Object?> get props => [];
}
