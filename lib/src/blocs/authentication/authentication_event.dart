part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged({required this.status, required this.authType,this.user});
  final dynamic authType;
  final AuthenticationStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => [status, user, authType];

  @override
  String toString() => 'AuthenticationStatusChanged {status:$status, user:$user}';
}

class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();

  @override
  String toString() => 'LogoutRequested';
}
