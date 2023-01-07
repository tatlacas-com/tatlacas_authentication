part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class ChangeAuthStatusEvent extends AuthEvent {
  const ChangeAuthStatusEvent({
    required this.status,
    required this.authType,
    this.user,
    required this.initialAuth,
  });

  final dynamic authType;
  final AuthenticationStatus status;
  final UserEntity? user;
  final bool initialAuth;

  @override
  List<Object?> get props => [status, user, authType, initialAuth];
}

class LogoutRequestedEvent extends AuthEvent {
  final bool userRequested;

  const LogoutRequestedEvent({
    required this.userRequested,
  });

  @override
  List<Object> get props => [userRequested];
}

class IdTokenExpiredEvent extends AuthEvent {
  final String refreshToken;

  IdTokenExpiredEvent({required this.refreshToken});

  @override
  List<Object> get props => [refreshToken];
}
