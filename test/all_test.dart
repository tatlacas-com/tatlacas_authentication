import 'blocs/authentication/authentication_bloc_test.dart' as authentication_bloc_test;
import 'blocs/authentication/authentication_event_test.dart' as authentication_event_test;
import 'blocs/authentication/authentication_state_test.dart' as authentication_state_test;

void main(){
//region blocs
  authentication_bloc_test.main();
  authentication_event_test.main();
  authentication_state_test.main();
//endregion
}