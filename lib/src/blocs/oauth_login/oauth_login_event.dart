part of 'oauth_login_bloc.dart';

abstract class OauthLoginEvent extends Equatable {
  const OauthLoginEvent();

  @override
  List<Object?> get props => [];
}

class RetryRequested extends OauthLoginEvent{

  @override
  String toString() => 'RetryRequested';
}

class OauthLoginRequested extends OauthLoginEvent {
  @override
  String toString() => 'OauthLoginRequested';
}
