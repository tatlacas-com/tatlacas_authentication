import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';

import 'oauth_login_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationBloc, UserRepository, OauthRepository])
void main() {
  group('OauthLoginBloc', () {
    late OauthLoginBloc bloc;
    late AuthenticationBloc authBloc;
    late UserRepository userRepository;
    late OauthRepository oauthRepository;
    late UserEntity testUser;
    setUp(() {
      authBloc = MockAuthenticationBloc();
      userRepository = MockUserRepository();
      oauthRepository = MockOauthRepository();
      testUser =
          UserEntity.fromJson({'id': 'testing123', 'accessToken': 'xyz'});
      when(oauthRepository.authenticate()).thenAnswer((invocation) {
        return Future.value(testUser);
      });
      when(userRepository.saveUser(testUser)).thenAnswer((invocation) =>
          Future.value(UserEntity.fromJson({'id': 'testing123'})));
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
            authType: "azure",
          ))).thenThrow(Exception('ops'));
          return bloc;
        },
        act: (bloc) async => bloc.add(OauthLoginRequested(
              authType: "azure",
            )),
        expect: () => <OauthLoginState>[
              OauthLoginInProgress(),
              OauthLoginFailed(),
            ]);

    blocTest<OauthLoginBloc, OauthLoginState>(
        'should emit OauthLoginFailed on repository throws',
        build: () {
          when(oauthRepository.authenticate()).thenThrow(Exception('ops'));
          return bloc;
        },
        act: (bloc) async => bloc.add(OauthLoginRequested(
              authType: "azure",
            )),
        expect: () => <OauthLoginState>[
              OauthLoginInProgress(),
              OauthLoginFailed(),
            ]);

    blocTest<OauthLoginBloc, OauthLoginState>(
      'should emit in progress and succeeded',
      build: () => bloc,
      act: (bloc) async => bloc.add(OauthLoginRequested(
        authType: "azure",
      )),
      expect: () => <OauthLoginState>[
        OauthLoginInProgress(),
        OauthLoginSucceeded(),
      ],
    );
  });
}
