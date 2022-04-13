part of 'oauth_login_bloc.dart';

abstract class OauthLoginEvent extends Equatable {
  const OauthLoginEvent();

  @override
  List<Object?> get props => [];
}

class RetryRequested extends OauthLoginEvent {

  @override
  String toString() => 'RetryRequested';
}

class OauthLoginRequested extends OauthLoginEvent {
  final dynamic authType;

  @override
  List<Object> get props => [authType];

  const OauthLoginRequested({
    required this.authType,
  });
}
