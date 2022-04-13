import 'package:flutter_test/flutter_test.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';

void main() {
  group('AuthenticationEvent', () {
    group('AuthenticationStatusChanged', () {
      test('toString returns correct value', () {
        expect(
            AuthenticationStatusChanged(
              authType: "azure",
              status: AuthenticationStatus.authenticated,
              user: UserEntity.fromJson({
                'givenName': 'Test',
                'familyName': 'User',
                'id': '4',
              }),
            ).toString(),
            'AuthenticationStatusChanged {status:${AuthenticationStatus.authenticated}, user:${UserEntity.fromJson({
                  'givenName': 'Test',
                  'familyName': 'User',
                  'id': '4',
                })}}');
      });
    });
    group('LogoutRequested', () {
      test('toString returns correct value', () {
        expect(LogoutRequested().toString(), 'LogoutRequested');
      });
    });
  });
}
