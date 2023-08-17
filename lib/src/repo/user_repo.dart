import 'package:tatlacas_sqflite_storage/sql.dart';

import '../model/user_entity.dart';

abstract class UserRepo<TEntity extends UserEntity> {
  final SqlStorage _repo;
  TEntity get type;

  const UserRepo({required SqlStorage storage}) : this._repo = storage;

  Future<TEntity> saveUser(TEntity user) async {
    await _repo.delete(
        where: (typeProvider) => SqlWhere(
              type.columnId,
              condition: SqlCondition.NotNull,
            ));
    return await _repo.insert(user) as TEntity;
  }

  Future<TEntity?> getUser() async {
    var user = await _repo.getEntity(
        where: (typeProvider) => SqlWhere(
              type.columnId,
              condition: SqlCondition.NotNull,
            ));
    if (user == null) return null;
    return getUserFrom(user);
  }

  Future<TEntity?> getUserFrom(Map<String, dynamic> map);

  Future<void> removeUser() async {
    await _repo.delete(
      where: (typeProvider) => SqlWhere(
        type.columnId,
        condition: SqlCondition.NotNull,
      ),
    );
  }
}
