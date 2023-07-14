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

  factory AuthUnknownState.copy(
    AuthState curr, {
    UserEntity? account,
    bool showAllSignInOptions = false,
  }) {
    return AuthUnknownState(
      initialAuth: curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions,
    );
  }
}

class AuthInitializingState extends AuthState {
  AuthInitializingState({
    required super.initialAuth,
    required super.showAllSignInOptions,
  });

  factory AuthInitializingState.copy(
    AuthState curr, {
    UserEntity? account,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return AuthInitializingState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
    );
  }
}

class AuthenticatedState extends AuthState {
  AuthenticatedState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    required super.account,
  });

  factory AuthenticatedState.copy(
    AuthState curr, {
    UserEntity? account,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return AuthenticatedState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
      account: account,
    );
  }

  @override
  List<Object?> get props => [account, initialAuth];
}

class ProfileUpdatedState extends AuthState {
  ProfileUpdatedState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    required super.account,
  });

  factory ProfileUpdatedState.copy(
    AuthState curr, {
    UserEntity? account,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return ProfileUpdatedState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
      account: account,
    );
  }

  @override
  List<Object?> get props => [account, initialAuth];
}

class UnauthenticatedState extends AuthState {
  UnauthenticatedState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    super.account,
  });

  factory UnauthenticatedState.copy(
    AuthState curr, {
    UserEntity? account,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return UnauthenticatedState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
      account: account,
    );
  }
}

class LoggedOutState extends AuthState {
  final bool userRequested;

  LoggedOutState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    required super.account,
    required this.userRequested,
  });

  factory LoggedOutState.copy(
    AuthState curr, {
    UserEntity? account,
    required bool userRequested,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return LoggedOutState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
      account: account,
      userRequested: userRequested,
    );
  }
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

  factory IdTokenExpiredState.copy(
    AuthState curr, {
    UserEntity? account,
    required String refreshToken,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return IdTokenExpiredState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
      account: account,
      refreshToken: refreshToken,
    );
  }

  @override
  List<Object?> get props => super.props.followedBy([refreshToken]).toList();
}

class AuthenticatingState extends AuthState {
  AuthenticatingState({
    required super.initialAuth,
    required super.showAllSignInOptions,
    super.account,
  });

  factory AuthenticatingState.copy(
    AuthState curr, {
    UserEntity? account,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return AuthenticatingState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
      account: account,
    );
  }
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

  factory AuthFailedState.copy(
    AuthState curr, {
    UserEntity? account,
    dynamic authType,
    bool? initialAuth,
    bool? showAllSignInOptions,
  }) {
    return AuthFailedState(
      initialAuth: initialAuth ?? curr.initialAuth,
      showAllSignInOptions: showAllSignInOptions ?? curr.showAllSignInOptions,
      account: account,
      authType: authType,
    );
  }

  @override
  List<Object?> get props => super.props.followedBy([authType]).toList();
}
