import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('AuthenticationBloc', () {
    late UserRepository userRepository;
    late AuthenticationBloc bloc;

    setUp(() {
      userRepository = MockUserRepository();
      bloc = AuthenticationBloc(userRepository: userRepository);
    });

    test('should emit AuthUnknown as correct initial state', () {
      expect(bloc.state, AuthUnknownState());
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit AuthFailed if repository throws',
      build: () {
        when(userRepository.getUser()).thenThrow(Exception('ops'));
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
        AuthInitializingState(),
        AuthFailedState(
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
        when(userRepository.getUser())
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
        AuthInitializingState(),
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
        when(userRepository.getUser()).thenAnswer((_) => Future.value(null));
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
        AuthInitializingState(),
        UnauthenticatedState(),
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
        UnauthenticatedState(),
      ],
    );
  });
}
