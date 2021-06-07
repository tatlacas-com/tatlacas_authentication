import 'package:flutter_test/flutter_test.dart';
import 'package:ndaza_authentication/ndaza_authentication.dart';

void main(){
  group('OauthLoginState',(){

    group('OauthLoginInitial', (){
      test('toString returns correct value', (){
        expect(OauthLoginInitial().toString(), 'OauthLoginInitial');
      });
    });

    group('OauthLoginInProgress', (){
      test('toString returns correct value', (){
        expect(OauthLoginInProgress().toString(), 'OauthLoginInProgress');
      });
    });

    group('OauthLoginSucceeded', (){
      test('toString returns correct value', (){
        expect(OauthLoginSucceeded().toString(), 'OauthLoginSucceeded');
      });
    });

    group('OauthLoginFailed', (){
      test('toString returns correct value', (){
        expect(OauthLoginFailed().toString(), 'OauthLoginFailed');
      });
    });
  });
}