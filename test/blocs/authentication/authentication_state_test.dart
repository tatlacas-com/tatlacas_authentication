import 'package:flutter_test/flutter_test.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';

void main() {
  group('AuthenticationState', () {
    group('AuthUnknown', () {
      test('AuthUnknown toString returns correct value', () {
        expect(
            AuthUnknownState(
              initialAuthentication: true,
            ).toString(),
            'AuthUnknown');
      });
    });
    group('AuthInitializing', () {
      test('toString returns correct value', () {
        expect(
            AuthInitializingState(
              initialAuthentication: true,
            ).toString(),
            'AuthInitializing');
      });
    });
    group('Authenticated', () {
      test('toString returns correct value', () {
        expect(
            AuthenticatedState(
                initialAuthentication: true,
                user: UserEntity.fromJson({
                  'givenName': 'Test',
                  'familyName': 'User',
                  'id': '4',
                })).toString(),
            'Authenticated {user: ${UserEntity.fromJson({
                  'givenName': 'Test',
                  'familyName': 'User',
                  'id': '4',
                })}}');
      });
    });
    group('Unauthenticated', () {
      test('toString returns correct value', () {
        expect(
            UnauthenticatedState(
              initialAuthentication: true,
            ).toString(),
            'Unauthenticated');
      });
    });
    group('AuthFailed', () {
      test('AuthFailed toString returns correct value', () {
        expect(
            AuthFailedState(
              initialAuthentication: true,
              authType: "azure",
            ).toString(),
            'AuthFailed');
      });
    });
  });
}
