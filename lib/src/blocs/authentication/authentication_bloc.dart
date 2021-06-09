import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.userRepository})
      : super(const AuthUnknown());

  final UserRepository userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield* _mapAuthenticationChangedToState(event);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationChangedToState(
      AuthenticationStatusChanged event) async* {
    try {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          yield const Unauthenticated();
          break;
        case AuthenticationStatus.initializing:
          yield const AuthInitializing();
          var currUser = await userRepository.getUser();
          if (currUser != null) {
            yield Authenticated(user: currUser);
          } else
            yield const Unauthenticated();
          break;
        case AuthenticationStatus.authenticated:
          yield Authenticated(user: event.user!);
          break;
        default:
          yield const AuthUnknown();
          break;
      }
    } catch (_) {
      yield const AuthFailed();
    }
  }
}
