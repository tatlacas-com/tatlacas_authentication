part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  initializing,
  authenticated,
  unauthenticated,
  authenticating,
  authFailed,
}

abstract class AuthenticationState extends Equatable {
  final UserEntity? account;

  final timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp];

  AuthenticationState({
    this.account,
  });
}

class AuthUnknownState extends AuthenticationState {
  AuthUnknownState();
}

class AuthInitializingState extends AuthenticationState {
  AuthInitializingState();
}

class AuthenticatedState extends AuthenticationState {
  final bool initialAuthentication;

  AuthenticatedState({
    required this.initialAuthentication,
    required UserEntity user,
  }) : super(account: user);

  @override
  List<Object?> get props => [account, initialAuthentication];
}

class UnauthenticatedState extends AuthenticationState {
  UnauthenticatedState();
}

class LoggedOutState extends AuthenticationState {
  final bool userRequested;

  LoggedOutState({required this.userRequested});

  @override
  List<Object?> get props => [timestamp, userRequested];
}

class AuthenticatingState extends AuthenticationState {
  AuthenticatingState();
}

///Must only be emitted when something unexpected happens during authentication
///
///e.g authenticated but with null user
class AuthFailedState extends AuthenticationState {
  final dynamic authType;

  AuthFailedState({required this.authType});

  @override
  List<Object> get props => [authType];
}
