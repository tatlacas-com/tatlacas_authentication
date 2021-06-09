// Mocks generated by Mockito 5.0.9 from annotations
// in ndaza_authentication/test/blocs/oauth_login/oauth_login_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc/src/bloc.dart' as _i9;
import 'package:bloc/src/transition.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:ndaza_authentication/src/blocs/authentication/authentication_bloc.dart'
    as _i3;
import 'package:oauth_repository/src/models/oauth_config.dart' as _i7;
import 'package:oauth_repository/src/oauth_repository.dart' as _i10;
import 'package:tatlacas_flutter_oauth/flutter_appauth.dart' as _i6;
import 'package:user_repository/src/models/user_entity.dart' as _i5;
import 'package:user_repository/src/user_repository.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUserRepository extends _i1.Fake implements _i2.UserRepository {}

class _FakeAuthenticationState extends _i1.Fake
    implements _i3.AuthenticationState {}

class _FakeStreamSubscription<T> extends _i1.Fake
    implements _i4.StreamSubscription<T> {}

class _FakeUserEntity extends _i1.Fake implements _i5.UserEntity {}

class _FakeFlutterAppAuth extends _i1.Fake implements _i6.FlutterAppAuth {}

class _FakeOAuthConfig extends _i1.Fake implements _i7.OAuthConfig {}

/// A class which mocks [AuthenticationBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationBloc extends _i1.Mock
    implements _i3.AuthenticationBloc {
  MockAuthenticationBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get userRepository =>
      (super.noSuchMethod(Invocation.getter(#userRepository),
          returnValue: _FakeUserRepository()) as _i2.UserRepository);
  @override
  _i3.AuthenticationState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeAuthenticationState()) as _i3.AuthenticationState);
  @override
  _i4.Stream<_i3.AuthenticationState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.AuthenticationState>.empty())
          as _i4.Stream<_i3.AuthenticationState>);
  @override
  _i4.Stream<_i3.AuthenticationState> mapEventToState(
          _i3.AuthenticationEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i3.AuthenticationState>.empty())
          as _i4.Stream<_i3.AuthenticationState>);
  @override
  void add(_i3.AuthenticationEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.AuthenticationEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>>
      transformEvents(
              _i4.Stream<_i3.AuthenticationEvent>? events,
              _i9.TransitionFunction<_i3.AuthenticationEvent, _i3.AuthenticationState>?
                  transitionFn) =>
          (super.noSuchMethod(
                  Invocation.method(#transformEvents, [events, transitionFn]),
                  returnValue:
                      Stream<_i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>>.empty())
              as _i4.Stream<
                  _i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>>);
  @override
  void emit(_i3.AuthenticationState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>>
      transformTransitions(
              _i4.Stream<_i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue:
                      Stream<_i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>>.empty())
              as _i4.Stream<
                  _i8.Transition<_i3.AuthenticationEvent, _i3.AuthenticationState>>);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future.value()) as _i4.Future<void>);
  @override
  _i4.StreamSubscription<_i3.AuthenticationState> listen(
          void Function(_i3.AuthenticationState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription<_i3.AuthenticationState>())
          as _i4.StreamSubscription<_i3.AuthenticationState>);
  @override
  void onChange(_i8.Change<_i3.AuthenticationState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i2.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i5.UserEntity> saveUser(_i5.UserEntity? user) =>
      (super.noSuchMethod(Invocation.method(#saveUser, [user]),
              returnValue: Future<_i5.UserEntity>.value(_FakeUserEntity()))
          as _i4.Future<_i5.UserEntity>);
  @override
  _i4.Future<_i5.UserEntity?> getUser() =>
      (super.noSuchMethod(Invocation.method(#getUser, []),
              returnValue: Future<_i5.UserEntity?>.value())
          as _i4.Future<_i5.UserEntity?>);
}

/// A class which mocks [OauthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOauthRepository extends _i1.Mock implements _i10.OauthRepository {
  MockOauthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.FlutterAppAuth get flutterAppAuth =>
      (super.noSuchMethod(Invocation.getter(#flutterAppAuth),
          returnValue: _FakeFlutterAppAuth()) as _i6.FlutterAppAuth);
  @override
  _i7.OAuthConfig get oAuthConfig =>
      (super.noSuchMethod(Invocation.getter(#oAuthConfig),
          returnValue: _FakeOAuthConfig()) as _i7.OAuthConfig);
  @override
  _i4.Future<_i5.UserEntity?> authenticate() =>
      (super.noSuchMethod(Invocation.method(#authenticate, []),
              returnValue: Future<_i5.UserEntity?>.value())
          as _i4.Future<_i5.UserEntity?>);
}
