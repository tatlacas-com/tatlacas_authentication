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
  final bool showAllSignInOptions;

  final timestamp = DateTime.now();

  @override
  List<Object?> get props => [
        account,
        timestamp,
        initialAuth,
        showAllSignInOptions,
      ];

  AuthState({
    required this.initialAuth,
    this.account,
    this.showAllSignInOptions = false,
  });
}

class AuthUnknownState extends AuthState {
  AuthUnknownState({
    required super.initialAuth,
    super.showAllSignInOptions = false,
  });
}

class AuthInitializingState extends AuthState {
  AuthInitializingState({
    required super.initialAuth,
    required super.showAllSignInOptions,
  });
}

class AuthenticatedState extends AuthState {
  AuthenticatedState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    required super.account,
  });

  @override
  List<Object?> get props => [account, initialAuth];
}

class ProfileUpdatedState extends AuthState {
  ProfileUpdatedState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    required super.account,
  });

  @override
  List<Object?> get props => [account, initialAuth];
}

class UnauthenticatedState extends AuthState {
  UnauthenticatedState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    super.account,
  });
}

class LoggedOutState extends AuthState {
  final bool userRequested;

  LoggedOutState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    required super.account,
    required this.userRequested,
  });

  @override
  List<Object?> get props => super.props.followedBy([userRequested]).toList();
}

class IdTokenExpiredState extends AuthState {
  final String refreshToken;

  IdTokenExpiredState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    required super.account,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => super.props.followedBy([refreshToken]).toList();
}

class AuthenticatingState extends AuthState {
  AuthenticatingState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    super.account,
  });
}

///Must only be emitted when something unexpected happens during authentication
///
///e.g authenticated but with null user
class AuthFailedState extends AuthState {
  final dynamic authType;

  AuthFailedState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    super.account,
    required this.authType,
  });

  @override
  List<Object?> get props => super.props.followedBy([authType]).toList();
}
