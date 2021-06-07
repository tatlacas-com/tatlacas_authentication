import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.unknown());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AuthenticationStatusChanged){
      yield* _mapAuthenticationChangedToState(event);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationChangedToState(AuthenticationStatusChanged event) async* {
    switch(event.status){
      case AuthenticationStatus.unauthenticated:
        yield const AuthenticationState.unauthenticated();
        break;
      case AuthenticationStatus.initializing:
        yield const AuthenticationState.initializing();
        //todo check if user already signed in here
        Future.delayed(Duration(seconds: 2));
        yield const AuthenticationState.unauthenticated();
        break;
      case AuthenticationStatus.authenticated:
        //todo get profile and other stuff here
        yield const AuthenticationState.authenticated();
        break;
      default:
        yield const AuthenticationState.unknown();
        break;
    }
  }
}
