import 'package:flutter_test/flutter_test.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';

void main() {
  group('OauthLoginEvent', () {
    group('OauthLoginRequested', () {
      test('toString returns correct value', () {
        expect(OauthLoginRequested().toString(), 'OauthLoginRequested');
      });
    });
  });
}
