part of 'oauth_login_bloc.dart';

abstract class OauthLoginEvent extends Equatable {
  const OauthLoginEvent();

  @override
  List<Object?> get props => [];
}

class OauthLoginRequested extends OauthLoginEvent {
  @override
  String toString() => 'OauthLoginRequested';
}
