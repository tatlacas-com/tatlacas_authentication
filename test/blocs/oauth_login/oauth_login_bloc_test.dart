import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';
import 'package:tatlacas_flutter_oauth/app_auth_export.dart';

import 'oauth_login_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationBloc, UserRepo, OauthRepo])
void main() {
  group('OauthLoginBloc', () {
    late OauthLoginBloc bloc;
    late AuthenticationBloc authBloc;
    late UserRepo userRepo;
    late OauthRepo oauthRepo;
    late AuthorizationTokenResponse testResponse;
    var user = UserEntity.fromJson({'id': 'testing123', 'accessToken': 'xyz'});
    setUp(() {
      authBloc = MockAuthenticationBloc();
      userRepo = MockUserRepo();
      oauthRepo = MockOauthRepo();
      testResponse = AuthorizationTokenResponse('xyz','xyz',DateTime.now(),'xyz','id',
          {},null);
      when(oauthRepo.authenticate("azure",params: {})).thenAnswer((invocation) {
        return Future.value(testResponse);
      });
      when(bloc.createUser(testResponse)).thenAnswer((invocation) {
        return Future.value(user);
      });
      when(userRepo.saveUser(user)).thenAnswer((invocation) =>
          Future.value(UserEntity.fromJson({'id': 'testing123'})));
      bloc = OauthLoginBloc(
        authBloc: authBloc,
        userRepo: userRepo,
        oauthRepo: oauthRepo,
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
          when(oauthRepo.authenticate("azure",params: {})).thenThrow(Exception('ops'));
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
