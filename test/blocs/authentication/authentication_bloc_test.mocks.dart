// Mocks generated by Mockito 5.0.9 from annotations
// in ndaza_authentication/test/blocs/authentication/authentication_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:ndaza_authentication/src/repos/user_repository/models/user_entity.dart'
    as _i2;
import 'package:ndaza_authentication/src/repos/user_repository/user_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUserEntity extends _i1.Fake implements _i2.UserEntity {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserEntity> saveUser(_i2.UserEntity? user) =>
      (super.noSuchMethod(Invocation.method(#saveUser, [user]),
              returnValue: Future<_i2.UserEntity>.value(_FakeUserEntity()))
          as _i4.Future<_i2.UserEntity>);
  @override
  _i4.Future<_i2.UserEntity?> getUser() =>
      (super.noSuchMethod(Invocation.method(#getUser, []),
              returnValue: Future<_i2.UserEntity?>.value())
          as _i4.Future<_i2.UserEntity?>);
  @override
  _i4.Future<void> removeUser() =>
      (super.noSuchMethod(Invocation.method(#removeUser, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
}
