import 'package:tatlacas_sqflite_storage/sql.dart';

class UserEntity extends Entity<UserEntity> {
  final String? givenName;
  final String? familyName;
  final String? username;
  final String? xmppJid;
  final String? xmppPassword;
  final bool profileDownloaded;
  final String? fcmToken;
  final String? accessToken;

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity().load(json);
  }

  get columnGivenName => SqlColumn<UserEntity, String>(
        'givenName',
        read: (entity) => entity.givenName,
        write: (entity, value) => entity.copyWith(givenName: value),
      );

  get columnFamilyName => SqlColumn<UserEntity, String>(
        'familyName',
        read: (entity) => entity.familyName,
        write: (entity, value) => entity.copyWith(familyName: value),
      );

  get columnUsername => SqlColumn<UserEntity, String>(
        'username',
        read: (entity) => entity.username,
        write: (entity, value) => entity.copyWith(username: value),
      );

  get columnXmppJid => SqlColumn<UserEntity, String>(
        'xmppJid',
        read: (entity) => entity.xmppJid,
        write: (entity, value) => entity.copyWith(xmppJid: value),
      );

  get columnXmppPassword => SqlColumn<UserEntity, String>(
        'xmppPassword',
        read: (entity) => entity.xmppPassword,
        write: (entity, value) => entity.copyWith(xmppPassword: value),
      );

  get columnProfileDownloaded => SqlColumn<UserEntity, bool>(
        'profileDownloaded',
        read: (entity) => entity.profileDownloaded,
        write: (entity, value) =>
            entity.copyWith(profileDownloaded: value ?? false),
      );

  get columnFcmToken => SqlColumn<UserEntity, String>(
        'fcmToken',
        read: (entity) => entity.fcmToken,
        write: (entity, value) => entity.copyWith(fcmToken: value),
      );

  get columnAccessToken => SqlColumn<UserEntity, String>(
        'accessToken',
        read: (entity) => entity.accessToken,
        write: (entity, value) => entity.copyWith(accessToken: value),
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
  List<Object?> get props => super.props.followedBy([
        givenName,
        familyName,
        username,
        xmppJid,
        xmppPassword,
        profileDownloaded,
        fcmToken,
        accessToken,
      ]).toList();

  @override
  String get tableName => 'user';

  @override
  String toString() => indentedString({"UserEntity": toJson()});

  @override
  UserEntity setBaseParams(
      {String? id, DateTime? createdAt, DateTime? updatedAt}) {
    return this.copyWith(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  const UserEntity({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.givenName,
    this.familyName,
    this.username,
    this.xmppJid,
    this.xmppPassword,
    this.profileDownloaded = false,
    this.fcmToken,
    this.accessToken,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  UserEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? givenName,
    String? familyName,
    String? username,
    String? xmppJid,
    String? xmppPassword,
    bool? profileDownloaded,
    String? fcmToken,
    String? accessToken,
  }) {
    return UserEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      givenName: givenName ?? this.givenName,
      familyName: familyName ?? this.familyName,
      username: username ?? this.username,
      xmppJid: xmppJid ?? this.xmppJid,
      xmppPassword: xmppPassword ?? this.xmppPassword,
      profileDownloaded: profileDownloaded ?? this.profileDownloaded,
      fcmToken: fcmToken ?? this.fcmToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
