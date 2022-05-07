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

  String? get profilePictureThumbnailUrl;

  String? get largeProfilePictureUrl;

  bool get verified;

  UserEntity copyWith({
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
    String? xmppPassword,
    bool? profileDownloaded,
    bool? verified,
    String? fcmToken,
    String? accessToken,
    String? profilePictureThumbnailUrl,
    String? largeProfilePictureUrl,
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
  final String? profilePictureThumbnailUrl;
  final String? largeProfilePictureUrl;
  final bool verified;

  SqlColumn<TEntity, bool> get columnVerified => SqlColumn<TEntity, bool>(
        'verified',
        read: (entity) => entity.verified,
        write: (entity, value) => entity.copyWith(verified: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnLargeProfilePictureUrl =>
      SqlColumn<TEntity, String>(
        'largeProfilePictureUrl',
        read: (entity) => entity.largeProfilePictureUrl,
        write: (entity, value) =>
            entity.copyWith(largeProfilePictureUrl: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnProfilePictureThumbnailUrl =>
      SqlColumn<TEntity, String>(
        'profilePictureThumbnailUrl',
        read: (entity) => entity.profilePictureThumbnailUrl,
        write: (entity, value) =>
            entity.copyWith(profilePictureThumbnailUrl: value) as TEntity,
      );

  String? get constructedFullName =>
      fullName ??
      ((givenName?.isNotEmpty != true && familyName?.isNotEmpty != true)
          ? null
          : '${givenName ?? ''} ${familyName ?? ''}');

  SqlColumn<TEntity, String> get columnPhone => SqlColumn<TEntity, String>(
        'phone',
        read: (entity) => entity.phone,
        write: (entity, value) => entity.copyWith(phone: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnEmail => SqlColumn<TEntity, String>(
        'email',
        read: (entity) => entity.email,
        write: (entity, value) => entity.copyWith(email: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnGivenName => SqlColumn<TEntity, String>(
        'givenName',
        read: (entity) => entity.givenName,
        write: (entity, value) => entity.copyWith(givenName: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnFamilyName => SqlColumn<TEntity, String>(
        'familyName',
        read: (entity) => entity.familyName,
        write: (entity, value) => entity.copyWith(familyName: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnUsername => SqlColumn<TEntity, String>(
        'username',
        read: (entity) => entity.username,
        write: (entity, value) => entity.copyWith(username: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnXmppJid => SqlColumn<TEntity, String>(
        'xmppJid',
        read: (entity) => entity.xmppJid,
        write: (entity, value) => entity.copyWith(xmppJid: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnXmppPassword =>
      SqlColumn<TEntity, String>(
        'xmppPassword',
        read: (entity) => entity.xmppPassword,
        write: (entity, value) =>
            entity.copyWith(xmppPassword: value) as TEntity,
      );

  SqlColumn<TEntity, bool> get columnProfileDownloaded =>
      SqlColumn<TEntity, bool>(
        'profileDownloaded',
        read: (entity) => entity.profileDownloaded,
        write: (entity, value) =>
            entity.copyWith(profileDownloaded: value ?? false) as TEntity,
      );

  SqlColumn<TEntity, String> get columnFcmToken => SqlColumn<TEntity, String>(
        'fcmToken',
        read: (entity) => entity.fcmToken,
        write: (entity, value) => entity.copyWith(fcmToken: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnAccessToken =>
      SqlColumn<TEntity, String>(
        'accessToken',
        read: (entity) => entity.accessToken,
        write: (entity, value) =>
            entity.copyWith(accessToken: value) as TEntity,
      );

  SqlColumn<TEntity, String> get columnFullName => SqlColumn<TEntity, String>(
        'fullName',
        read: (entity) => entity.fullName,
        write: (entity, value) => entity.copyWith(fullName: value) as TEntity,
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
        columnProfilePictureThumbnailUrl,
        columnLargeProfilePictureUrl,
        columnVerified,
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
        fullName,
        email,
        verified,
        phone,
        accessToken,
        profilePictureThumbnailUrl,
        largeProfilePictureUrl,
      ]).toList();

  @override
  String get tableName => 'user';

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
    this.phone,
    this.xmppPassword,
    this.profilePictureThumbnailUrl,
    this.largeProfilePictureUrl,
    this.profileDownloaded = false,
    this.verified = false,
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
    String? fullName,
    String? email,
    String? phone,
    String? xmppPassword,
    bool? profileDownloaded,
    bool? verified,
    String? fcmToken,
    String? accessToken,
    String? profilePictureThumbnailUrl,
    String? largeProfilePictureUrl,
  });
}
