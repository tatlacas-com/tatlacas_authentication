part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  initializing,
  authenticated,
  unauthenticated,
  authenticating,
  authFailed,
  profileUpdated,
}

abstract class AuthenticationState extends Equatable {
  final UserEntity? account;
  final bool initialAuthentication;

  final timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp, initialAuthentication];

  AuthenticationState({
    required this.initialAuthentication,
    this.account,
  });
}

class AuthUnknownState extends AuthenticationState {
  AuthUnknownState({
    required bool initialAuthentication,
  }) : super(initialAuthentication: initialAuthentication);
}

class AuthInitializingState extends AuthenticationState {
  AuthInitializingState({
    required bool initialAuthentication,
  }) : super(initialAuthentication: initialAuthentication);
}

class AuthenticatedState extends AuthenticationState {
  AuthenticatedState({
    required bool initialAuthentication,
    required UserEntity user,
  }) : super(
          account: user,
          initialAuthentication: initialAuthentication,
        );

  @override
  List<Object?> get props => [account, initialAuthentication];
}

class ProfileUpdatedState extends AuthenticationState {
  ProfileUpdatedState({
    required bool initialAuthentication,
    required UserEntity user,
  }) : super(
          account: user,
          initialAuthentication: initialAuthentication,
        );

  @override
  List<Object?> get props => [account, initialAuthentication];
}

class UnauthenticatedState extends AuthenticationState {
  UnauthenticatedState({
    required bool initialAuthentication,
  }) : super(initialAuthentication: initialAuthentication);
}

class LoggedOutState extends AuthenticationState {
  final bool userRequested;

  LoggedOutState({
    required bool initialAuthentication,
    required this.userRequested,
    required UserEntity? account,
  }) : super(
          initialAuthentication: userRequested,
          account: account,
        );

  @override
  List<Object?> get props => super.props.followedBy([userRequested]).toList();
}

class AuthenticatingState extends AuthenticationState {
  AuthenticatingState({
    required bool initialAuthentication,
  }) : super(initialAuthentication: initialAuthentication);
}

///Must only be emitted when something unexpected happens during authentication
///
///e.g authenticated but with null user
class AuthFailedState extends AuthenticationState {
  final dynamic authType;

  AuthFailedState({
    required bool initialAuthentication,
    required this.authType,
  }) : super(initialAuthentication: initialAuthentication);

  @override
  List<Object?> get props => super.props.followedBy([authType]).toList();
}
