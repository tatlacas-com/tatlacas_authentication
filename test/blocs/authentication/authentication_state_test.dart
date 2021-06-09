import 'package:flutter_test/flutter_test.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('AuthenticationState', () {
    group('AuthUnknown', () {
      test('AuthUnknown toString returns correct value', () {
        expect(AuthUnknown().toString(), 'AuthUnknown');
      });
    });
    group('AuthInitializing', () {
      test('toString returns correct value', () {
        expect(AuthInitializing().toString(), 'AuthInitializing');
      });
    });
    group('Authenticated', () {
      test('toString returns correct value', () {
        expect(
            Authenticated(
                user: UserEntity(
              givenName: 'Test',
              familyName: 'User',
              id: '4',
            )).toString(),
            'Authenticated {user: ${UserEntity(
              givenName: 'Test',
              familyName: 'User',
              id: '4',
            )}}');
      });
    });
    group('Unauthenticated', () {
      test('toString returns correct value', () {
        expect(Unauthenticated().toString(), 'Unauthenticated');
      });
    });
    group('AuthFailed', () {
      test('AuthFailed toString returns correct value', () {
        expect(AuthFailed().toString(), 'AuthFailed');
      });
    });
  });
}
