part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class ChangeAuthStatusEvent extends AuthenticationEvent {

  const ChangeAuthStatusEvent({
    required this.status,
    required this.authType,
    this.user,
    required this.initialAuthentication,
  });

  final dynamic authType;
  final AuthenticationStatus status;
  final UserEntity? user;
  final bool initialAuthentication;

  @override
  List<Object?> get props => [status, user, authType, initialAuthentication];
}

class LogoutRequestedEvent extends AuthenticationEvent {
  final bool userRequested;

  const LogoutRequestedEvent({
    required this.userRequested,
  });

  @override
  List<Object> get props => [userRequested];
}
