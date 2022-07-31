import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tatlacas_authentication/src/model/user_entity.dart';
import 'package:tatlacas_authentication/src/repo/user_repo.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

abstract class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo userRepo;

  AuthenticationBloc({required this.userRepo})
      : super(AuthUnknownState(
          initialAuthentication: true,
        )) {
    on<ChangeAuthStatusEvent>(onChangeAuthStatusEvent);
    on<LogoutRequestedEvent>(onLogoutRequestedEvent);
  }

  FutureOr<void> onLogoutRequestedEvent(
      LogoutRequestedEvent event, Emitter<AuthenticationState> emit) async {
    UserEntity? account;
    if(event.userRequested){
       await userRepo.removeUser();
    }else{
      account = state.account;
    }
    emit(
      LoggedOutState(
        initialAuthentication: event.userRequested,
        userRequested: event.userRequested,
        account: account,
      ),
    );
  }

  FutureOr<void> onChangeAuthStatusEvent(
      ChangeAuthStatusEvent event, Emitter<AuthenticationState> emit) async {
    try {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          emit(UnauthenticatedState(
            initialAuthentication: event.initialAuthentication,
          ));
          break;
        case AuthenticationStatus.authenticating:
          emit(AuthenticatingState(
            initialAuthentication: event.initialAuthentication,
          ));
          break;
        case AuthenticationStatus.authFailed:
          emit(AuthFailedState(
            initialAuthentication: event.initialAuthentication,
            account: event.user,
            authType: event.authType,
          ));
          break;
        case AuthenticationStatus.initializing:
          emit(AuthInitializingState(
            initialAuthentication: event.initialAuthentication,
          ));
          var currUser = await userRepo.getUser();
          if (currUser?.accessToken != null) {
            emit(AuthenticatedState(
              initialAuthentication: event.initialAuthentication,
              user: currUser!,
            ));
          } else
            emit(UnauthenticatedState(
              initialAuthentication: event.initialAuthentication,
            ));
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
          emit(AuthUnknownState(
            initialAuthentication: event.initialAuthentication,
          ));
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthFailedState(
        initialAuthentication: event.initialAuthentication,
        account: event.user,
        authType: event.authType,
      ));
    }
  }
}
