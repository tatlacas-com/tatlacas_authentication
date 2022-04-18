import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';
import 'package:tatlacas_flutter_oauth/app_auth_export.dart';
import 'package:uuid/uuid.dart';

part 'oauth_login_event.dart';

part 'oauth_login_state.dart';

class OauthLoginBloc extends Bloc<OauthLoginEvent, OauthLoginState> {
  @protected
  final AuthenticationBloc authenticationBloc;
  @protected
  final UserRepository userRepository;
  @protected
  final OauthRepository oauthRepository;

  bool get initialAuthentication =>
      authenticationBloc.state.initialAuthentication;

  OauthLoginBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.oauthRepository,
  }) : super(OauthLoginInitial()) {
    on<OauthLoginRequestedEvent>(_onOauthLoginRequested);
    on<RetryRequestedEvent>(_onRetryRequested);
  }

  FutureOr<void> _onRetryRequested(
      RetryRequestedEvent event, Emitter<OauthLoginState> emit) {
    emit(const OauthLoginInitial());
    authenticationBloc.add(ChangeAuthStatusEvent(
        initialAuthentication: event.initialAuthentication,
        status: AuthenticationStatus.unauthenticated,
        authType: null));
  }

  FutureOr<void> _onOauthLoginRequested(
      OauthLoginRequestedEvent event, Emitter<OauthLoginState> emit) async {
    try {
      authenticationBloc.add(ChangeAuthStatusEvent(
        status: AuthenticationStatus.authenticating,
        authType: event.authType,
        initialAuthentication: event.initialAuthentication,
      ));
      emit(const OauthLoginInProgress());

      var authResponse = await oauthRepository.authenticate(event.authType);
      UserEntity? user;
      if (authResponse != null) user = await createUser(authResponse);
      if (user != null) {
        emit(const OauthLoginSucceeded());
        user = await userRepository.saveUser(user);
        await Future.delayed(Duration(milliseconds: 500));
        authenticationBloc.add(ChangeAuthStatusEvent(
          initialAuthentication: event.initialAuthentication,
          status: AuthenticationStatus.authenticated,
          user: user,
          authType: event.authType,
        ));
      } else {
        emit(const OauthLoginFailed());
        authenticationBloc.add(ChangeAuthStatusEvent(
          initialAuthentication: event.initialAuthentication,
          status: AuthenticationStatus.authFailed,
          authType: event.authType,
        ));
      }
    } catch (e) {
      emit(const OauthLoginFailed());
      authenticationBloc.add(ChangeAuthStatusEvent(
        initialAuthentication: event.initialAuthentication,
        status: AuthenticationStatus.authFailed,
        authType: event.authType,
      ));
    }
  }

  Future<UserEntity?> createUser(AuthorizationTokenResponse response) async {
    if (response.idToken?.isNotEmpty == true) {
      var entity = UserEntity(id: Uuid().v4(), accessToken: response.idToken);
      return entity;
    }
    return null;
  }
}
