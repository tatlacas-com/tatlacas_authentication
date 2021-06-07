import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../authentication/authentication_bloc.dart';

part 'oauth_login_event.dart';

part 'oauth_login_state.dart';

class OauthLoginBloc extends Bloc<OauthLoginEvent, OauthLoginState> {
  OauthLoginBloc({required this.authenticationBloc})
      : super(OauthLoginInitial());
  final AuthenticationBloc authenticationBloc;

  @override
  Stream<OauthLoginState> mapEventToState(
    OauthLoginEvent event,
  ) async* {
    if (event is OauthLoginRequested) {
      yield* _mapOauthLoginRequestedToState();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  Stream<OauthLoginState> _mapOauthLoginRequestedToState() async* {
    try {
      yield const OauthLoginInProgress();
      //todo request oauth login
      await Future.delayed(Duration(seconds: 2));
      yield const OauthLoginSucceeded();
      await Future.delayed(Duration(seconds: 2));
      authenticationBloc.add(AuthenticationStatusChanged(
          status: AuthenticationStatus.authenticated));
    } catch (e) {
      yield const OauthLoginFailed();
    }
  }
}
