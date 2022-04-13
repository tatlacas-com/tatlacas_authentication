import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ndaza_authentication/src/repos/user_repository/models/user_entity.dart';
import 'package:ndaza_authentication/src/repos/user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthUnknownState()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<LogoutRequested>(_onLogoutRequested);
  }

  FutureOr<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthenticationState> emit) async {
    await userRepository.removeUser();
    emit(UnauthenticatedState());
  }

  FutureOr<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    try {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          emit(UnauthenticatedState());
          break;
        case AuthenticationStatus.authenticating:
          emit(AuthenticatingState());
          break;
        case AuthenticationStatus.authFailed:
          emit(AuthFailedState(
            authType: event.authType,
          ));
          break;
        case AuthenticationStatus.initializing:
          emit(AuthInitializingState());
          var currUser = await userRepository.getUser();
          if (currUser?.accessToken != null) {
            emit(AuthenticatedState(user: currUser!));
          } else
            emit(UnauthenticatedState());
          break;
        case AuthenticationStatus.authenticated:
          emit(AuthenticatedState(user: event.user!));
          break;
        default:
          emit(AuthUnknownState());
          break;
      }
    } catch (_) {
      emit(AuthFailedState(
        authType: event.authType,
      ));
    }
  }
}
