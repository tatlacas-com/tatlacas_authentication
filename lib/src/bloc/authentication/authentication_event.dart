part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class ChangeAuthStatusEvent extends AuthenticationEvent {
  final BuildContext? context;

  const ChangeAuthStatusEvent({
    required this.status,
    this.context,
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
  final BuildContext? context;

  const LogoutRequestedEvent({
    required this.userRequested,
    this.context,
  });

  @override
  List<Object> get props => [userRequested];
}
