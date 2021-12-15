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
      : super(const AuthUnknown()){
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<LogoutRequested>(_onLogoutRequested);
  }



  FutureOr<void> _onLogoutRequested(LogoutRequested event,
  Emitter<AuthenticationState> emit) async {
    await userRepository.removeUser();
    emit(const Unauthenticated());
  }

  FutureOr<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    try {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          emit(const Unauthenticated());
          break;
        case AuthenticationStatus.initializing:
          emit(const AuthInitializing());
          var currUser = await userRepository.getUser();
          if (currUser?.accessToken != null) {
            emit(Authenticated(user: currUser!));
          } else
            emit(const Unauthenticated());
          break;
        case AuthenticationStatus.authenticated:
          emit(Authenticated(user: event.user!));
          break;
        default:
          emit(const AuthUnknown());
          break;
      }
    } catch (_) {
      emit(const AuthFailed());
    }
  }
}
