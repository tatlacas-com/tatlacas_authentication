import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:tatlacas_authentication/src/bloc/authentication/authentication_bloc.dart';
import 'package:tatlacas_authentication/src/model/user_entity.dart';
import 'package:tatlacas_authentication/src/repo/oauth_repo.dart';
import 'package:tatlacas_authentication/src/repo/user_repo.dart';
import 'package:tatlacas_flutter_oauth/app_auth_export.dart';

part 'oauth_login_event.dart';

part 'oauth_login_state.dart';

abstract class OauthLoginBloc<TRepo extends OauthRepo,
        TAuthBloc extends AuthenticationBloc>
    extends Bloc<OauthLoginEvent, OauthLoginState> {
  @protected
  final TAuthBloc authBloc;
  @protected
  final UserRepo userRepo;
  @protected
  final TRepo oauthRepo;

  bool get initialAuth =>
      authBloc.state.initialAuth;

  OauthLoginBloc({
    required this.authBloc,
    required this.userRepo,
    required this.oauthRepo,
  }) : super(OauthLoginInitial()) {
    on<OauthLoginRequestedEvent>(_onOauthLoginRequested);
    on<RetryRequestedEvent>(_onRetryRequested);
  }

  FutureOr<void> _onRetryRequested(
      RetryRequestedEvent event, Emitter<OauthLoginState> emit) {
    emit(const OauthLoginInitial());
    authBloc.add(ChangeAuthStatusEvent(
      initialAuthentication: event.initialAuthentication,
      status: AuthenticationStatus.unauthenticated,
      authType: null,
    ));
  }

  FutureOr<void> _onOauthLoginRequested(
      OauthLoginRequestedEvent event, Emitter<OauthLoginState> emit) async {
    try {
      authBloc.add(ChangeAuthStatusEvent(
        status: AuthenticationStatus.authenticating,
        authType: event.authType,
        initialAuthentication: event.initialAuthentication,
      ));
      emit(const OauthLoginInProgress());

      var authResponse = await oauthRepo.authenticate(
        event.authType,
        params: event.params,
      );
      UserEntity? user;
      if (authResponse != null) user = await createUser(event, authResponse);
      if (user != null) {
        emit(const OauthLoginSucceeded());
        user = await userRepo.saveUser(user);
        await Future.delayed(Duration(milliseconds: 500));
        authBloc.add(ChangeAuthStatusEvent(
          initialAuthentication: event.initialAuthentication,
          status: AuthenticationStatus.authenticated,
          user: user,
          authType: event.authType,
        ));
      } else {
        emit(const OauthLoginFailed());
        authBloc.add(ChangeAuthStatusEvent(
          initialAuthentication: event.initialAuthentication,
          status: AuthenticationStatus.authFailed,
          authType: event.authType,
        ));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(OauthLoginFailed(exception: e));
      authBloc.add(ChangeAuthStatusEvent(
        initialAuthentication: event.initialAuthentication,
        status: AuthenticationStatus.authFailed,
        authType: event.authType,
      ));
    }
  }

  Future<UserEntity?> createUser(
      OauthLoginRequestedEvent event, AuthorizationTokenResponse response);
}
