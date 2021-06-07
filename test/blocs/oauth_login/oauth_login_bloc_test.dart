import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';
import 'package:ndaza_user_repository/ndaza_user_repository.dart';

import 'oauth_login_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationBloc, UserRepository])
void main() {
  group('OauthLoginBloc', () {
    late OauthLoginBloc bloc;
    late AuthenticationBloc authBloc;
    late UserRepository userRepository;
    setUp(() {
      authBloc = MockAuthenticationBloc();
      userRepository = MockUserRepository();
      when(userRepository.saveUser(UserEntity(id: 'testing123')))
          .thenAnswer((invocation) {
        return Future.value(invocation.positionalArguments[0] as UserEntity);
      });
      bloc = OauthLoginBloc(
        authenticationBloc: authBloc,
        userRepository: userRepository,
      );
    });

    test('should have OauthLoginInitial as initial state', () {
      expect(bloc.state, OauthLoginInitial());
    });

    blocTest<OauthLoginBloc, OauthLoginState>(
        'should emit OauthLoginFailed on authentication throws',
        build: () {
          when(authBloc.add(AuthenticationStatusChanged(
                  status: AuthenticationStatus.authenticated,)))
              .thenThrow(Exception('ops'));
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
          when(userRepository.saveUser(UserEntity(id: 'testing123')))
              .thenThrow(Exception('ops'));
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
                  status: AuthenticationStatus.authenticated, )))
              .thenAnswer((invocation) {
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
