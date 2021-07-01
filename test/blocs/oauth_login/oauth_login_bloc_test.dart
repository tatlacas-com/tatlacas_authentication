import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';
import 'package:ndaza_authentication/oauth_repository.dart';
import 'package:ndaza_authentication/user_repository.dart';

import 'oauth_login_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationBloc, UserRepository, OauthRepository])
void main() {
  group('OauthLoginBloc', () {
    late OauthLoginBloc bloc;
    late AuthenticationBloc authBloc;
    late UserRepository userRepository;
    late OauthRepository oauthRepository;
    setUp(() {
      authBloc = MockAuthenticationBloc();
      userRepository = MockUserRepository();
      oauthRepository = MockOauthRepository();
      when(oauthRepository.authenticate()).thenAnswer((invocation) {
        return Future.value(UserEntity(id: 'testing123'));
      });
      when(userRepository.saveUser(UserEntity(id: 'testing123'))).thenAnswer(
          (invocation) => Future.value(UserEntity(id: 'testing123')));
      bloc = OauthLoginBloc(
        authenticationBloc: authBloc,
        userRepository: userRepository,
        oauthRepository: oauthRepository,
      );
    });

    test('should have OauthLoginInitial as initial state', () {
      expect(bloc.state, OauthLoginInitial());
    });

    blocTest<OauthLoginBloc, OauthLoginState>(
        'should emit OauthLoginFailed on authentication throws',
        build: () {
          when(authBloc.add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated,
          ))).thenThrow(Exception('ops'));
          return bloc;
        },
        act: (bloc) async => bloc.add(OauthLoginRequested()),
        expect: () => <OauthLoginState>[
              OauthLoginInProgress(),
              OauthLoginSucceeded(),
              OauthLoginFailed(),
            ]);

    blocTest<OauthLoginBloc, OauthLoginState>(
        'should emit OauthLoginFailed on repository throws',
        build: () {
          when(oauthRepository.authenticate()).thenThrow(Exception('ops'));
          return bloc;
        },
        act: (bloc) async => bloc.add(OauthLoginRequested()),
        expect: () => <OauthLoginState>[
              OauthLoginInProgress(),
              OauthLoginFailed(),
            ]);

    UserEntity? authenticatedUser;
    blocTest<OauthLoginBloc, OauthLoginState>(
        'should emit in progress and succeeded',
        build: () {
          when(authBloc.add(AuthenticationStatusChanged(
            status: AuthenticationStatus.authenticated,
          ))).thenAnswer((invocation) {
            var event = invocation.positionalArguments[0]
                as AuthenticationStatusChanged;
            expect(event.user, isNotNull);
            authenticatedUser = event.user;
            when(authBloc.state).thenReturn(Authenticated(user: event.user!));
          });
          return bloc;
        },
        act: (bloc) async => bloc.add(OauthLoginRequested()),
        expect: () => <OauthLoginState>[
              OauthLoginInProgress(),
              OauthLoginSucceeded(),
            ],
        verify: (bloc) {
          expect(authenticatedUser, isNotNull);
          expect(
              authBloc.state,
              Authenticated(
                user: authenticatedUser!,
              ));
        });
  });
}
