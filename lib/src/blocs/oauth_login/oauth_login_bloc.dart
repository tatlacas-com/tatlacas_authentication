import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';
import 'package:ndaza_authentication/src/repos/oauth_repository/oauth_repository.dart';
import 'package:ndaza_authentication/src/repos/user_repository/user_repository.dart';
import 'package:tatlacas_flutter_oauth/app_auth_export.dart';
import 'package:uuid/uuid.dart';

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
  }) : super(OauthLoginInitial()) {
    on<OauthLoginRequested>(_onOauthLoginRequested);
    on<RetryRequested>(_onRetryRequested);
  }

  FutureOr<void> _onRetryRequested(
      RetryRequested event, Emitter<OauthLoginState> emit) {
    emit(const OauthLoginInitial());
    authenticationBloc.add(AuthenticationStatusChanged(
        status: AuthenticationStatus.unauthenticated, authType: null));
  }

  FutureOr<void> _onOauthLoginRequested(
      OauthLoginRequested event, Emitter<OauthLoginState> emit) async {
    try {
      authenticationBloc.add(AuthenticationStatusChanged(
        status: AuthenticationStatus.authenticating,
        authType: event.authType,
      ));
      emit(const OauthLoginInProgress());

      var authResponse = await oauthRepository.authenticate();
      UserEntity? user;
      if (authResponse != null) user = await createUser(authResponse);
      if (user != null) {
        emit(const OauthLoginSucceeded());
        user = await userRepository.saveUser(user);
        await Future.delayed(Duration(milliseconds: 500));
        authenticationBloc.add(AuthenticationStatusChanged(
          status: AuthenticationStatus.authenticated,
          user: user,
          authType: event.authType,
        ));
      } else {
        emit(const OauthLoginFailed());
        authenticationBloc.add(AuthenticationStatusChanged(
          status: AuthenticationStatus.authFailed,
          authType: event.authType,
        ));
      }
    } catch (e) {
      emit(const OauthLoginFailed());
      authenticationBloc.add(AuthenticationStatusChanged(
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
