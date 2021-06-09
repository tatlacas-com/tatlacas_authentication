import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:oauth_repository/oauth_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../authentication/authentication_bloc.dart';

part 'oauth_login_event.dart';

part 'oauth_login_state.dart';

class OauthLoginBloc extends Bloc<OauthLoginEvent, OauthLoginState> {
  OauthLoginBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.oauthRepository,
  }) : super(OauthLoginInitial());
  @protected
  final AuthenticationBloc authenticationBloc;
  @protected
  final UserRepository userRepository;
  @protected
  final OauthRepository oauthRepository;

  @override
  Stream<OauthLoginState> mapEventToState(
    OauthLoginEvent event,
  ) async* {
    if (event is OauthLoginRequested) {
      yield* _mapOauthLoginRequestedToState();
    }
   else if (event is RetryRequested) {
      yield const OauthLoginInitial();
    }
  }

  Stream<OauthLoginState> _mapOauthLoginRequestedToState() async* {
    try {
      yield const OauthLoginInProgress();

      var user = await oauthRepository.authenticate();
      if (user?.accessToken != null) {
        yield const OauthLoginSucceeded();
        user = await userRepository.saveUser(user!);
        await Future.delayed(Duration(milliseconds: 500));
        authenticationBloc.add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated, user: user));
      } else {
        yield const OauthLoginFailed();
      }
    } catch (e) {
      yield const OauthLoginFailed();
    }
  }
}
