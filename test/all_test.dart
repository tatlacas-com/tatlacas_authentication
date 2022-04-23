import 'blocs/authentication/authentication_bloc_test.dart' as authentication_bloc_test;
import 'blocs/authentication/authentication_event_test.dart' as authentication_event_test;
import 'blocs/authentication/authentication_state_test.dart' as authentication_state_test;

import 'blocs/oauth_login/oauth_login_bloc_test.dart' as oauth_login_bloc_test;
import 'blocs/oauth_login/oauth_login_event_test.dart' as oauth_login_event_test;
import 'blocs/oauth_login/oauth_login_state_test.dart' as oauth_login_state_test;

void main(){
//region bloc
  authentication_bloc_test.main();
  authentication_event_test.main();
  authentication_state_test.main();

  oauth_login_bloc_test.main();
  oauth_login_event_test.main();
  oauth_login_state_test.main();
//endregion
}