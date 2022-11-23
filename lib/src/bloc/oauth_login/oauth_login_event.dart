part of 'oauth_login_bloc.dart';

abstract class OauthLoginEvent extends Equatable {
  const OauthLoginEvent();

  @override
  List<Object?> get props => [];
}

class RetryRequestedEvent extends OauthLoginEvent {
  final bool initialAuth;

  @override
  List<Object> get props => [initialAuth];

  const RetryRequestedEvent({
    required this.initialAuth,
  });
}

class OauthLoginRequestedEvent extends OauthLoginEvent {
  final dynamic authType;
  final UserEntity? currUser;
  final Map<String, dynamic> params;

  final bool initialAuth;

  @override
  List<Object?> get props =>
      [authType, initialAuth, params, currUser];

  const OauthLoginRequestedEvent({
    required this.authType,
    required this.initialAuth,
    this.currUser,
    this.params = const <String, String>{},
  });
}
