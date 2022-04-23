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
final Map<String, dynamic> params;

final bool initialAuthentication;

@override
List<Object> get props => [authType, initialAuthentication,params];

const OauthLoginRequestedEvent({
required this.authType,
required this.initialAuthentication,
this.params =const <String, String>{},
});
}
