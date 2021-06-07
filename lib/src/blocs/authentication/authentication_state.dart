part of 'authentication_bloc.dart';
enum AuthenticationStatus{unknown,initializing,authenticated,unauthenticated}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  const AuthenticationState._({this.status = AuthenticationStatus.unknown});


  const AuthenticationState.unknown():this._();
  const AuthenticationState.initializing():this._(status:AuthenticationStatus.initializing);
  const AuthenticationState.authenticated():this._(status:AuthenticationStatus.authenticated);
  const AuthenticationState.unauthenticated():this._(status:AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status];

  @override
  String toString() => 'AuthenticationState {status:$status}';
}

