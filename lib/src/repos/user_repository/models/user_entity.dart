import 'package:tatlacas_sql_storage/tatlacas_sql_storage.dart';

class UserEntity extends Entity<UserEntity> {
  late final String? givenName;
  late final String? familyName;
  late final String? username;
  late final String? xmppJid;
  late final String? xmppPassword;
  late final bool profileDownloaded;
  late final String? fcmToken;
  late final String? accessToken;

  UserEntity();


  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity().load(json);
  }


  get columnGivenName => SqlColumn<UserEntity, String>(
        'givenName',
        read: (entity) => entity.givenName,
        write: (entity, value) => entity.givenName = value,
      );

  get columnFamilyName => SqlColumn<UserEntity, String>(
        'familyName',
        read: (entity) => entity.familyName,
        write: (entity, value) => entity.familyName = value,
      );

  get columnUsername => SqlColumn<UserEntity, String>(
        'username',
        read: (entity) => entity.username,
        write: (entity, value) => entity.username = value,
      );

  get columnXmppJid => SqlColumn<UserEntity, String>(
        'xmppJid',
        read: (entity) => entity.xmppJid,
        write: (entity, value) => entity.xmppJid = value,
      );

  get columnXmppPassword => SqlColumn<UserEntity, String>(
        'xmppPassword',
        read: (entity) => entity.xmppPassword,
        write: (entity, value) => entity.xmppPassword = value,
      );

  get columnProfileDownloaded => SqlColumn<UserEntity, bool>(
        'profileDownloaded',
        read: (entity) => entity.profileDownloaded,
        write: (entity, value) => entity.profileDownloaded = value ?? false,
      );

  get columnFcmToken => SqlColumn<UserEntity, String>(
        'fcmToken',
        read: (entity) => entity.fcmToken,
        write: (entity, value) => entity.fcmToken = value,
      );

  get columnAccessToken => SqlColumn<UserEntity, String>(
        'accessToken',
        read: (entity) => entity.accessToken,
        write: (entity, value) => entity.accessToken = value,
      );

  @override
  Iterable<SqlColumn<UserEntity, dynamic>> get columns => [
        columnGivenName,
        columnFamilyName,
        columnUsername,
        columnXmppJid,
        columnXmppPassword,
        columnProfileDownloaded,
        columnFcmToken,
        columnAccessToken,
      ];

  @override
  List<Object?> get props => [
        id,
        givenName,
        familyName,
        username,
        xmppJid,
        xmppPassword,
        profileDownloaded,
        fcmToken,
        accessToken,
      ];

  @override
  String get tableName => 'user';

  @override
  String toString() =>
      'UserEntity {id:$id, givenName:$givenName, familyName:$familyName, username:$username, xmppJid:$xmppJid, xmppPassword:${xmppPassword?.isNotEmpty == true ? 'present' : 'null'}, profileDownloaded:$profileDownloaded, fcmToken:${fcmToken?.isNotEmpty == true ? 'present' : 'null'}, accessToken:${accessToken?.isNotEmpty == true ? 'present' : 'null'}';
}
