import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';

void main() {
  group('AuthenticationEvent', () {
    group('AuthenticationStatusChanged', () {
      test('toString returns correct value', () {
        expect(
            ChangeAuthStatusEvent(
              initialAuthentication: true,
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
        expect(
            LogoutRequestedEvent(
              userRequested: true,
            ).toString(),
            'LogoutRequested');
      });
    });
  });
}
