import 'package:tatlacas_sqflite_storage/sql.dart';

import '../model/user_entity.dart';

class UserRepo {
  final SqlStorage _repo;
  static final UserEntity _type = UserEntity();

  const UserRepo({required SqlStorage storage}) : this._repo = storage;

  Future<UserEntity> saveUser(UserEntity user) async {
    await _repo.delete(_type,
        where: SqlWhere(
          _type.columnId,
          condition: SqlCondition.NotNull,
        ));
    return await _repo.insert(user) as UserEntity;
  }

  Future<UserEntity?> getUser() async {
    var user = await _repo.getEntity(_type,
        where: SqlWhere(
          _type.columnId,
          condition: SqlCondition.NotNull,
        ));
    if (user == null) return null;
    return UserEntity.fromJson(user);
  }

  Future<void> removeUser() async {
    await _repo.delete(
      _type,
      where: SqlWhere(
        _type.columnId,
        condition: SqlCondition.NotNull,
      ),
    );
  }
}
