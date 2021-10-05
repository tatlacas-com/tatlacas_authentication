import 'package:tatlacas_sql_storage/tatlacas_sql_storage.dart';

class UserEntity extends Entity {
  final String? givenName;
  final String? familyName;
  final String? username;
  final String? xmppJid;
  final String? xmppPassword;
  final bool profileDownloaded;
  final String? fcmToken;
  final String? accessToken;

  const UserEntity({
    String? id,
    this.givenName,
    this.familyName,
    this.username,
    this.xmppJid,
    this.xmppPassword,
    this.accessToken,
    this.profileDownloaded = false,
    this.fcmToken,
  }) : super(id: id);

  UserEntity.fromJson(Map<String, dynamic> json)
      : this.givenName = json['givenName'],
        this.familyName = json['familyName'],
        this.username = json['username'],
        this.accessToken = json['accessToken'],
        this.xmppJid = json['xmppJid'],
        this.xmppPassword = json['xmppPassword'],
        this.profileDownloaded = json['profileDownloaded'] == '1',
        this.fcmToken = json['fcmToken'],
        super(id: json['id']);

  get columnGivenName => SqlColumn<UserEntity, String>(
        'givenName',
        read: (entity) => entity.givenName,
      );

  get columnFamilyName => SqlColumn<UserEntity, String>(
        'familyName',
        read: (entity) => entity.familyName,
      );

  get columnUsername => SqlColumn<UserEntity, String>(
        'username',
        read: (entity) => entity.username,
      );

  get columnXmppJid => SqlColumn<UserEntity, String>(
        'xmppJid',
        read: (entity) => entity.xmppJid,
      );

  get columnXmppPassword => SqlColumn<UserEntity, String>(
        'xmppPassword',
        read: (entity) => entity.xmppPassword,
      );

  get columnProfileDownloaded => SqlColumn<UserEntity, bool>(
        'profileDownloaded',
        read: (entity) => entity.profileDownloaded,
      );

  get columnFcmToken => SqlColumn<UserEntity, String>(
        'fcmToken',
        read: (entity) => entity.fcmToken,
      );

  get columnAccessToken => SqlColumn<UserEntity, String>(
        'accessToken',
        read: (entity) => entity.accessToken,
      );

  @override
  List<SqlColumn<Entity, dynamic>> get columns => [
        columnId,
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
