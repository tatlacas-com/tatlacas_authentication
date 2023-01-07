part of 'auth_bloc.dart';

enum AuthenticationStatus {
  unknown,
  initializing,
  authenticated,
  unauthenticated,
  authenticating,
  authFailed,
  profileUpdated,
  refreshingToken,
}

abstract class AuthState extends Equatable {
  final UserEntity? account;
  final bool initialAuth;

  final timestamp = DateTime.now();

  @override
  List<Object?> get props => [timestamp, initialAuth];

  AuthState({
    required this.initialAuth,
    this.account,
  });
}

class AuthUnknownState extends AuthState {
  AuthUnknownState({
    required bool initialAuth,
  }) : super(initialAuth: initialAuth);
}

class AuthInitializingState extends AuthState {
  AuthInitializingState({
    required bool initialAuth,
  }) : super(initialAuth: initialAuth);
}

class AuthenticatedState extends AuthState {
  AuthenticatedState({
    required bool initialAuth,
    required UserEntity user,
  }) : super(
          account: user,
          initialAuth: initialAuth,
        );

  @override
  List<Object?> get props => [account, initialAuth];
}

class ProfileUpdatedState extends AuthState {
  ProfileUpdatedState({
    required bool initialAuth,
    required UserEntity user,
  }) : super(
          account: user,
          initialAuth: initialAuth,
        );

  @override
  List<Object?> get props => [account, initialAuth];
}

class UnauthenticatedState extends AuthState {
  UnauthenticatedState({
    required bool initialAuth,
  }) : super(initialAuth: initialAuth);
}

class LoggedOutState extends AuthState {
  final bool userRequested;

  LoggedOutState({
    required bool initialAuth,
    required this.userRequested,
    required UserEntity? account,
  }) : super(
          initialAuth: initialAuth,
          account: account,
        );

  @override
  List<Object?> get props => super.props.followedBy([userRequested]).toList();
}

class IdTokenExpiredState extends AuthState {
  final String refreshToken;

  IdTokenExpiredState({
    required bool initialAuth,
    required UserEntity? account,
    required this.refreshToken,
  }) : super(
          initialAuth: initialAuth,
          account: account,
        );

  @override
  List<Object?> get props => super.props.followedBy([refreshToken]).toList();
}

class AuthenticatingState extends AuthState {
  AuthenticatingState({
    required bool initialAuth,
  }) : super(initialAuth: initialAuth);
}

///Must only be emitted when something unexpected happens during authentication
///
///e.g authenticated but with null user
class AuthFailedState extends AuthState {
  final dynamic authType;

  AuthFailedState({
    required bool initialAuth,
    UserEntity? account,
    required this.authType,
  }) : super(
          initialAuth: initialAuth,
          account: account,
        );

  @override
  List<Object?> get props => super.props.followedBy([authType]).toList();
}
