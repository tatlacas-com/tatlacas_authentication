part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class ChangeAuthStatusEvent extends AuthenticationEvent {
  const ChangeAuthStatusEvent({required this.status, required this.authType,this.user});
  final dynamic authType;
  final AuthenticationStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => [status, user, authType];

  @override
  String toString() => 'AuthenticationStatusChanged {status:$status, user:$user}';
}

class LogoutRequestedEvent extends AuthenticationEvent {
  const LogoutRequestedEvent();

  @override
  String toString() => 'LogoutRequested';
}
