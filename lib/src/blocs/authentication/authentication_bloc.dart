import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tatlacas_authentication/src/repos/user_repository/models/user_entity.dart';
import 'package:tatlacas_authentication/src/repos/user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthUnknownState(initialAuthentication: true,)) {
    on<ChangeAuthStatusEvent>(_onChangeAuthStatusEvent);
    on<LogoutRequestedEvent>(_onLogoutRequestedEvent);
  }

  FutureOr<void> _onLogoutRequestedEvent(
      LogoutRequestedEvent event, Emitter<AuthenticationState> emit) async {
    await userRepository.removeUser();
    emit(LoggedOutState( initialAuthentication: event.userRequested,userRequested: event.userRequested));
  }

  FutureOr<void> _onChangeAuthStatusEvent(
      ChangeAuthStatusEvent event, Emitter<AuthenticationState> emit) async {
    try {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          emit(UnauthenticatedState( initialAuthentication: event.initialAuthentication,));
          break;
        case AuthenticationStatus.authenticating:
          emit(AuthenticatingState( initialAuthentication: event.initialAuthentication,));
          break;
        case AuthenticationStatus.authFailed:
          emit(AuthFailedState(
            initialAuthentication: event.initialAuthentication, authType: event.authType,
          ));
          break;
        case AuthenticationStatus.initializing:
          emit(AuthInitializingState( initialAuthentication: event.initialAuthentication,));
          var currUser = await userRepository.getUser();
          if (currUser?.accessToken != null) {
            emit(AuthenticatedState(
              initialAuthentication: event.initialAuthentication,
              user: currUser!,
            ));
          } else
            emit(UnauthenticatedState( initialAuthentication: event.initialAuthentication,));
          break;
        case AuthenticationStatus.authenticated:
          emit(AuthenticatedState(
            initialAuthentication: event.initialAuthentication,
            user: event.user!,
          ));
          break;
        case AuthenticationStatus.profileUpdated:
          emit(ProfileUpdatedState(
            initialAuthentication: event.initialAuthentication,
            user: event.user!,
          ));
          break;
        default:
          emit(AuthUnknownState( initialAuthentication: event.initialAuthentication,));
          break;
      }
    } catch (_) {
      emit(AuthFailedState(
        initialAuthentication: event.initialAuthentication,authType: event.authType,
      ));
    }
  }
}
