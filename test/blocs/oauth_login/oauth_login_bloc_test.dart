import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';
import 'package:tatlacas_flutter_oauth/app_auth_export.dart';

import 'oauth_login_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationBloc, UserRepository, OauthRepository])
void main() {
  group('OauthLoginBloc', () {
    late OauthLoginBloc bloc;
    late AuthenticationBloc authBloc;
    late UserRepository userRepository;
    late OauthRepository oauthRepository;
    late AuthorizationTokenResponse testResponse;
    var user = UserEntity.fromJson({'id': 'testing123', 'accessToken': 'xyz'});
    setUp(() {
      authBloc = MockAuthenticationBloc();
      userRepository = MockUserRepository();
      oauthRepository = MockOauthRepository();
      testResponse = AuthorizationTokenResponse('xyz','xyz',DateTime.now(),'xyz','id',
          {},null);
      when(oauthRepository.authenticate("azure",params: {})).thenAnswer((invocation) {
        return Future.value(testResponse);
      });
      when(bloc.createUser(testResponse)).thenAnswer((invocation) {
        return Future.value(user);
      });
      when(userRepository.saveUser(user)).thenAnswer((invocation) =>
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
          when(authBloc.add(ChangeAuthStatusEvent(
            initialAuthentication: true,
            status: AuthenticationStatus.authenticated,
            authType: "azure",
          ))).thenThrow(Exception('ops'));
          return bloc;
        },
        act: (bloc) async => bloc.add(OauthLoginRequestedEvent(
          initialAuthentication: true,
          authType: "azure",
            )),
        expect: () => <OauthLoginState>[
              OauthLoginInProgress(),
              OauthLoginFailed(),
            ]);

    blocTest<OauthLoginBloc, OauthLoginState>(
        'should emit OauthLoginFailed on repository throws',
        build: () {
          when(oauthRepository.authenticate("azure",params: {})).thenThrow(Exception('ops'));
          return bloc;
        },
        act: (bloc) async => bloc.add(OauthLoginRequestedEvent(
          initialAuthentication: true,
          authType: "azure",
            )),
        expect: () => <OauthLoginState>[
              OauthLoginInProgress(),
              OauthLoginFailed(),
            ]);

    blocTest<OauthLoginBloc, OauthLoginState>(
      'should emit in progress and succeeded',
      build: () => bloc,
      act: (bloc) async => bloc.add(OauthLoginRequestedEvent(
        initialAuthentication: true,
        authType: "azure",
      )),
      expect: () => <OauthLoginState>[
        OauthLoginInProgress(),
        OauthLoginSucceeded(),
      ],
    );
  });
}
