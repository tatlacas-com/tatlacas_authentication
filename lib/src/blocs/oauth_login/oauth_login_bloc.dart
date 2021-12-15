import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ndaza_authentication/src/repos/oauth_repository/oauth_repository.dart';
import 'package:ndaza_authentication/src/repos/user_repository/user_repository.dart';

import '../authentication/authentication_bloc.dart';

part 'oauth_login_event.dart';

part 'oauth_login_state.dart';

class OauthLoginBloc extends Bloc<OauthLoginEvent, OauthLoginState> {
  @protected
  final AuthenticationBloc authenticationBloc;
  @protected
  final UserRepository userRepository;
  @protected
  final OauthRepository oauthRepository;

  OauthLoginBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.oauthRepository,
  }) : super(OauthLoginInitial()){
    on<OauthLoginRequested>(_onOauthLoginRequested);
    on<RetryRequested>(_onRetryRequested);
  }


  FutureOr<void> _onRetryRequested(RetryRequested event,
      Emitter<OauthLoginState> emit) {
    emit(const OauthLoginInitial());
  }
  FutureOr<void> _onOauthLoginRequested(OauthLoginRequested event,
  Emitter<OauthLoginState> emit) async {
    try {
      emit(const OauthLoginInProgress());

      final  user = await oauthRepository.authenticate();
      if (user?.accessToken != null) {
        emit(const OauthLoginSucceeded());
        await userRepository.saveUser(user!);
        await Future.delayed(Duration(milliseconds: 500));
        authenticationBloc.add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated, user: user));
      } else {
        emit(const OauthLoginFailed());
      }
    } catch (e) {
      emit(const OauthLoginFailed());
    }
  }
}
