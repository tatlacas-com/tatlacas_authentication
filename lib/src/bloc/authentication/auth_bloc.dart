import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tatlacas_authentication/src/model/user_entity.dart';
import 'package:tatlacas_authentication/src/repo/user_repo.dart';

part 'auth_event.dart';

part 'auth_state.dart';

abstract class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo userRepo;

  AuthBloc({required this.userRepo})
      : super(AuthUnknownState(
          initialAuth: true,
        )) {
    on<ChangeAuthStatusEvent>(onChangeAuthStatusEvent);
    on<LogoutRequestedEvent>(onLogoutRequestedEvent);
    on<IdTokenExpiredEvent>(onIdTokenExpiredEvent);
  }

  FutureOr<void> onLogoutRequestedEvent(
      LogoutRequestedEvent event, Emitter<AuthState> emit) async {
    UserEntity? account;
    if (event.userRequested) {
      await userRepo.removeUser();
    } else {
      account = state.account;
    }
    emit(
      LoggedOutState(
        initialAuth: event.userRequested,
        userRequested: event.userRequested,
        account: account,
      ),
    );
  }

  FutureOr<void> onIdTokenExpiredEvent(
      IdTokenExpiredEvent event, Emitter<AuthState> emit) async {
    emit(
      IdTokenExpiredState(
        initialAuth: state.initialAuth,
        account: state.account,
        refreshToken: event.refreshToken,
      ),
    );
  }

  FutureOr<void> onChangeAuthStatusEvent(
      ChangeAuthStatusEvent event, Emitter<AuthState> emit) async {
    try {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          emit(UnauthenticatedState(
            initialAuth: event.initialAuth,
          ));
          break;
        case AuthenticationStatus.authenticating:
          emit(AuthenticatingState(
            initialAuth: event.initialAuth,
          ));
          break;
        case AuthenticationStatus.authFailed:
          emit(AuthFailedState(
            initialAuth: event.initialAuth,
            account: event.user,
            authType: event.authType,
          ));
          break;
        case AuthenticationStatus.initializing:
          emit(AuthInitializingState(
            initialAuth: event.initialAuth,
          ));
          var currUser = await userRepo.getUser();
          if (currUser?.accessToken != null) {
            emit(AuthenticatedState(
              initialAuth: event.initialAuth,
              user: currUser!,
            ));
          } else
            emit(UnauthenticatedState(
              initialAuth: event.initialAuth,
            ));
          break;
        case AuthenticationStatus.authenticated:
          emit(AuthenticatedState(
            initialAuth: event.initialAuth,
            user: event.user!,
          ));
          break;
        case AuthenticationStatus.profileUpdated:
          emit(ProfileUpdatedState(
            initialAuth: event.initialAuth,
            user: event.user!,
          ));
          break;
        default:
          emit(AuthUnknownState(
            initialAuth: event.initialAuth,
          ));
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthFailedState(
        initialAuth: event.initialAuth,
        account: event.user,
        authType: event.authType,
      ));
    }
  }
}
