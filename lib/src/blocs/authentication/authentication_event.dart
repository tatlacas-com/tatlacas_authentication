part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged({required this.status});

  final AuthenticationStatus status;

  @override
  List<Object?> get props => [status];

  @override
  String toString() => 'AuthenticationStatusChanged {status: $status}';
}

class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();

  @override
  String toString() => 'LogoutRequested';
}
