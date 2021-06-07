import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ndaza_user_repository/ndaza_user_repository.dart';

import '../authentication/authentication_bloc.dart';

part 'oauth_login_event.dart';

part 'oauth_login_state.dart';

class OauthLoginBloc extends Bloc<OauthLoginEvent, OauthLoginState> {
  OauthLoginBloc({required this.authenticationBloc,required this.userRepository})
      : super(OauthLoginInitial());
  @protected
  final AuthenticationBloc authenticationBloc;
  @protected
  final UserRepository userRepository;
  @override
  Stream<OauthLoginState> mapEventToState(
    OauthLoginEvent event,
  ) async* {
    if (event is OauthLoginRequested) {
      yield* _mapOauthLoginRequestedToState();
    }
  }

  Stream<OauthLoginState> _mapOauthLoginRequestedToState() async* {
    try {
      yield const OauthLoginInProgress();
      //todo request oauth login
      await Future.delayed(Duration(seconds: 2));
      var user = await userRepository.saveUser(UserEntity(id: 'testing123'));
      yield const OauthLoginSucceeded();
      //todo put a delay to transition to authenticated
      await Future.delayed(Duration(seconds: 2));
      authenticationBloc.add(AuthenticationStatusChanged(
          status: AuthenticationStatus.authenticated,
          user: user));
    } catch (e) {
      yield const OauthLoginFailed();
    }
  }
}
