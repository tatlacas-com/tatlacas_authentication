part of 'oauth_login_bloc.dart';

abstract class OauthLoginState extends Equatable {
  const OauthLoginState();

  @override
  List<Object> get props => [];
}

class OauthLoginInitial extends OauthLoginState {
  const OauthLoginInitial();
  @override
  String toString() => 'OauthLoginInitial';
}

class OauthLoginInProgress extends OauthLoginState {
  const OauthLoginInProgress();
  @override
  String toString() => 'OauthLoginInProgress';
}

class OauthLoginSucceeded extends OauthLoginState {
  const OauthLoginSucceeded();
  @override
  String toString() => 'OauthLoginSucceeded';
}

class OauthLoginFailed extends OauthLoginState {
  final dynamic exception;
  const OauthLoginFailed({this.exception});
  @override
  String toString() => 'OauthLoginFailed';
}
