import 'package:flutter_test/flutter_test.dart';
import 'package:tatlacas_authentication/tatlacas_authentication.dart';

void main() {
  group('OauthLoginEvent', () {
    group('OauthLoginRequested', () {
      test('toString returns correct value', () {
        expect(
            OauthLoginRequested(
              authType: "azure",
            ).toString(),
            'OauthLoginRequested');
      });
    });
    group('RetryRequested', () {
      test('toString returns correct value', () {
        expect(RetryRequested().toString(), 'RetryRequested');
      });
    });
  });
}
