part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  initializing,
  authenticated,
  unauthenticated
}

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthUnknown extends AuthenticationState {
  const AuthUnknown();
  @override
  String toString() => 'AuthUnknown';
}

class AuthInitializing extends AuthenticationState {
  const AuthInitializing();
  @override
  String toString() => 'AuthInitializing';
}

class Authenticated extends AuthenticationState {
  final UserEntity user;

  const Authenticated({required this.user});

  @override
  String toString() => 'Authenticated {user: $user}';

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
  @override
  String toString() => 'Unauthenticated';
}

///Must only be emitted when something unexpected happens during authentication
///
///e.g authenticated but with null user
class AuthFailed extends AuthenticationState{
  const AuthFailed();
  @override
  String toString() => 'AuthFailed';
}
