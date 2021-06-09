import 'package:tatlacas_sql_storage/tatlacas_sql_storage.dart';

import '../user_repository.dart';

class UserRepository {
  final SqlStorage _repo;
  static const UserEntity _type = UserEntity();

  const UserRepository({required SqlStorage repo}) : this._repo = repo;

  Future<UserEntity> saveUser(UserEntity user) async {
    return await _repo.insertOrUpdate(user) as UserEntity;
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
