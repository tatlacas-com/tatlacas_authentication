import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tatlacas_authentication/src/bloc/authentication/auth_bloc.dart';
import 'package:tatlacas_authentication/src/model/user_entity.dart';
import 'package:tatlacas_authentication/src/repo/user_repo.dart';

part 'oauth_login_event.dart';

part 'oauth_login_state.dart';

abstract class OauthLoginBloc<TAuthBloc extends AuthBloc>
    extends Bloc<OauthLoginEvent, OauthLoginState> {
  @protected
  final TAuthBloc authBloc;
  @protected
  final UserRepo userRepo;

  bool get initialAuth => authBloc.state.initialAuth;

  OauthLoginBloc({
    required this.authBloc,
    required this.userRepo,
  }) : super(OauthLoginInitial()) {
    on<OauthLoginRequestedEvent>(onOauthLoginRequested);
    on<RetryRequestedEvent>(onRetryRequested);
  }

  @protected
  FutureOr<void> onRetryRequested(
      RetryRequestedEvent event, Emitter<OauthLoginState> emit) {
    emit(const OauthLoginInitial());
    authBloc.add(ChangeAuthStatusEvent(
      initialAuth: event.initialAuth,
      status: AuthenticationStatus.unauthenticated,
      authType: null,
    ));
  }

  @protected
  FutureOr<void> onOauthLoginRequested(
      OauthLoginRequestedEvent event, Emitter<OauthLoginState> emit);

  @protected
  FutureOr<void> onFailed(Emitter<OauthLoginState> emit,
      OauthLoginRequestedEvent event, dynamic exception) {
    emit(OauthLoginFailed(exception: exception));
    authBloc.add(ChangeAuthStatusEvent(
      initialAuth: event.initialAuth,
      status: AuthenticationStatus.authFailed,
      authType: event.authType,
    ));
  }

  @protected
  Future<bool> onAuthSuccess(Emitter<OauthLoginState> emit,
      OauthLoginRequestedEvent event, UserEntity user) async {
    emit(const OauthLoginSucceeded());
    return true;
  }
}
