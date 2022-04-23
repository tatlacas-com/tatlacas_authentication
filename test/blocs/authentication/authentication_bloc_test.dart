import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([UserRepo])
void main() {
  group('AuthenticationBloc', () {
    late UserRepo userRepo;
    late AuthenticationBloc bloc;

    setUp(() {
      userRepo = MockUserRepo();
      bloc = AuthenticationBloc(userRepo: userRepo);
    });

    test('should emit AuthUnknown as correct initial state', () {
      expect(
          bloc.state,
          AuthUnknownState(
            initialAuthentication: true,
          ));
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit AuthFailed if repository throws',
      build: () {
        when(userRepo.getUser()).thenThrow(Exception('ops'));
        return bloc;
      },
      act: (bloc) async => bloc.add(
        ChangeAuthStatusEvent(
          initialAuthentication: true,
          authType: "azure",
          status: AuthenticationStatus.initializing,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthInitializingState(
          initialAuthentication: true,
        ),
        AuthFailedState(
          initialAuthentication: true,
          authType: "azure",
        ),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit Authenticated with correct user',
      build: () => bloc,
      act: (bloc) async => bloc.add(
        ChangeAuthStatusEvent(
          initialAuthentication: true,
          authType: "azure",
          status: AuthenticationStatus.authenticated,
          user: UserEntity.fromJson({
            'givenName': 'Test',
            'familyName': 'User',
            'id': '4',
          }),
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticatedState(
          initialAuthentication: true,
          user: UserEntity.fromJson({
            'givenName': 'Test',
            'familyName': 'User',
            'id': '4',
          }),
        ),
      ],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit Authenticated with correct user from repo',
      build: () {
        when(userRepo.getUser())
            .thenAnswer((_) => Future.value(UserEntity.fromJson({
                  'givenName': 'Test',
                  'familyName': 'User',
                  'accessToken': '1234',
                  'id': '4',
                })));
        return bloc;
      },
      act: (bloc) async => bloc.add(
        ChangeAuthStatusEvent(
          initialAuthentication: true,
          authType: "azure",
          status: AuthenticationStatus.initializing,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthInitializingState(
          initialAuthentication: true,
        ),
        AuthenticatedState(
          initialAuthentication: true,
          user: UserEntity.fromJson({
            'givenName': 'Test',
            'familyName': 'User',
            'accessToken': '1234',
            'id': '4',
          }),
        ),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit Unauthenticated if repo has no user',
      build: () {
        when(userRepo.getUser()).thenAnswer((_) => Future.value(null));
        return bloc;
      },
      act: (bloc) async => bloc.add(
        ChangeAuthStatusEvent(
          initialAuthentication: true,
          authType: "azure",
          status: AuthenticationStatus.initializing,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthInitializingState(
          initialAuthentication: true,
        ),
        UnauthenticatedState(
          initialAuthentication: true,
        ),
      ],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit Unauthenticated',
      build: () => bloc,
      act: (bloc) async => bloc.add(
        ChangeAuthStatusEvent(
          initialAuthentication: true,
          authType: "azure",
          status: AuthenticationStatus.unauthenticated,
        ),
      ),
      expect: () => <AuthenticationState>[
        UnauthenticatedState(
          initialAuthentication: true,
        ),
      ],
    );
  });
}
