part of 'oauth_login_bloc.dart';

abstract class OauthLoginEvent extends Equatable {
  const OauthLoginEvent();

  @override
  List<Object?> get props => [];
}

class RetryRequestedEvent extends OauthLoginEvent {

  final bool initialAuthentication;

  @override
  List<Object> get props => [initialAuthentication];

  const RetryRequestedEvent({
    required this.initialAuthentication,
  });
}

class OauthLoginRequestedEvent extends OauthLoginEvent {
  final dynamic authType;
final bool initialAuthentication;
  @override
  List<Object> get props => [authType,initialAuthentication];

  const OauthLoginRequestedEvent({
    required this.authType,
    required this.initialAuthentication,
  });
}
