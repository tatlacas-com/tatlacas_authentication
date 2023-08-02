import 'package:tatlacas_sqflite_storage/sql.dart';

abstract class IUserEntity extends IEntity {
  String? get givenName;

  String? get familyName;

  String? get username;

  String? get xmppJid;

  String? get xmppPassword;

  bool get profileDownloaded;

  String? get fcmToken;

  String? get accessToken;

  String? get fullName;

  String? get email;

  String? get phone;

  String? get avatarUrl;

  String? get smallAvatarUrl;

  String? get refreshToken;

  DateTime? get tokenExpiresOn;

  bool get verified;

  @override
  IUserEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? givenName,
    String? familyName,
    String? username,
    String? xmppJid,
    String? fullName,
    String? email,
    String? phone,
    String? refreshToken,
    DateTime? tokenExpiresOn,
    String? xmppPassword,
    bool? profileDownloaded,
    bool? verified,
    String? fcmToken,
    String? accessToken,
    String? avatarUrl,
    String? smallAvatarUrl,
  });
}

abstract class UserEntity<TEntity extends IUserEntity> extends Entity<TEntity>
    implements IUserEntity {
  final String? givenName;
  final String? familyName;
  final String? username;
  final String? xmppJid;
  final String? xmppPassword;
  final bool profileDownloaded;
  final String? fcmToken;
  final String? accessToken;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? smallAvatarUrl;
  final bool verified;
  final String? refreshToken;
  final DateTime? tokenExpiresOn;

  SqlColumn<TEntity, DateTime> get columnIdTokenExpiresOn =>
      SqlColumn<TEntity, DateTime>(
        'idTokenExpiresOn',
        saveToDb: (entity) => entity.tokenExpiresOn,
        readFromDb: (entity, value) =>
            entity.copyWith(tokenExpiresOn: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnRefreshToken =>
      SqlColumn<TEntity, String>(
        'refreshToken',
        saveToDb: (entity) => entity.refreshToken,
        readFromDb: (entity, value) =>
            entity.copyWith(refreshToken: value) as TEntity,
      );

  SqlColumn<TEntity, bool> get columnVerified => SqlColumn<TEntity, bool>(
        'verified',
        saveToDb: (entity) => entity.verified,
        readFromDb: (entity, value) =>
            entity.copyWith(verified: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnSmallAvatarUrl =>
      SqlColumn<TEntity, String>(
        'smallAvatarUrl',
        saveToDb: (entity) => entity.smallAvatarUrl,
        readFromDb: (entity, value) =>
            entity.copyWith(smallAvatarUrl: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnAvatarUrl => SqlColumn<TEntity, String>(
        'avatarUrl',
        saveToDb: (entity) => entity.avatarUrl,
        readFromDb: (entity, value) =>
            entity.copyWith(avatarUrl: value) as TEntity,
      );

  String? get constructedFullName =>
      fullName ??
      ((givenName?.isNotEmpty != true && familyName?.isNotEmpty != true)
          ? null
          : '${givenName ?? ''} ${familyName ?? ''}');

  SqlColumn<TEntity, String> get columnPhone => SqlColumn<TEntity, String>(
        'phone',
        saveToDb: (entity) => entity.phone,
        readFromDb: (entity, value) => entity.copyWith(phone: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnEmail => SqlColumn<TEntity, String>(
        'email',
        saveToDb: (entity) => entity.email,
        readFromDb: (entity, value) => entity.copyWith(email: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnGivenName => SqlColumn<TEntity, String>(
        'givenName',
        saveToDb: (entity) => entity.givenName,
        readFromDb: (entity, value) =>
            entity.copyWith(givenName: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnFamilyName => SqlColumn<TEntity, String>(
        'familyName',
        saveToDb: (entity) => entity.familyName,
        readFromDb: (entity, value) =>
            entity.copyWith(familyName: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnUsername => SqlColumn<TEntity, String>(
        'username',
        saveToDb: (entity) => entity.username,
        readFromDb: (entity, value) =>
            entity.copyWith(username: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnXmppJid => SqlColumn<TEntity, String>(
        'xmppJid',
        saveToDb: (entity) => entity.xmppJid,
        readFromDb: (entity, value) =>
            entity.copyWith(xmppJid: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnXmppPassword =>
      SqlColumn<TEntity, String>(
        'xmppPassword',
        saveToDb: (entity) => entity.xmppPassword,
        readFromDb: (entity, value) =>
            entity.copyWith(xmppPassword: value) as TEntity,
      );

  SqlColumn<TEntity, bool> get columnProfileDownloaded =>
      SqlColumn<TEntity, bool>(
        'profileDownloaded',
        saveToDb: (entity) => entity.profileDownloaded,
        readFromDb: (entity, value) =>
            entity.copyWith(profileDownloaded: value ?? false) as TEntity,
      );

  SqlColumn<TEntity, String> get columnFcmToken => SqlColumn<TEntity, String>(
        'fcmToken',
        saveToDb: (entity) => entity.fcmToken,
        readFromDb: (entity, value) =>
            entity.copyWith(fcmToken: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnAccessToken =>
      SqlColumn<TEntity, String>(
        'accessToken',
        saveToDb: (entity) => entity.accessToken,
        readFromDb: (entity, value) =>
            entity.copyWith(accessToken: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnFullName => SqlColumn<TEntity, String>(
        'fullName',
        saveToDb: (entity) => entity.fullName,
        readFromDb: (entity, value) =>
            entity.copyWith(fullName: value) as TEntity,
      );

  @override
  Iterable<SqlColumn<TEntity, dynamic>> get columns => [
        columnGivenName,
        columnFamilyName,
        columnUsername,
        columnXmppJid,
        columnXmppPassword,
        columnProfileDownloaded,
        columnFcmToken,
        columnFullName,
        columnEmail,
        columnPhone,
        columnAccessToken,
        columnAvatarUrl,
        columnSmallAvatarUrl,
        columnVerified,
        columnRefreshToken,
        columnIdTokenExpiresOn,
      ];

  @override
  List<Object?> get props => [
        ...super.props,
        givenName,
        familyName,
        username,
        xmppJid,
        xmppPassword,
        profileDownloaded,
        fcmToken,
        fullName,
        email,
        verified,
        phone,
        accessToken,
        avatarUrl,
        smallAvatarUrl,
        refreshToken,
        tokenExpiresOn,
      ];

  const UserEntity({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.givenName,
    this.familyName,
    this.username,
    this.xmppJid,
    this.fullName,
    this.email,
    this.refreshToken,
    this.tokenExpiresOn,
    this.phone,
    this.xmppPassword,
    this.avatarUrl,
    this.smallAvatarUrl,
    this.profileDownloaded = false,
    this.verified = false,
    this.fcmToken,
    this.accessToken,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);
  @override
  TEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? refreshToken,
    DateTime? tokenExpiresOn,
    String? givenName,
    String? familyName,
    String? username,
    String? xmppJid,
    String? fullName,
    String? email,
    String? phone,
    String? xmppPassword,
    bool? profileDownloaded,
    bool? verified,
    String? fcmToken,
    String? accessToken,
    String? avatarUrl,
    String? smallAvatarUrl,
  });
}
