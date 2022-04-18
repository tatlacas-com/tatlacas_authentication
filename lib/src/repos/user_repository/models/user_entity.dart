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
  final String? fullName;
  final String? email;
  final String? phone;
  final String? profilePictureThumbnailUrl;
  final String? largeProfilePictureUrl;

  SqlColumn<UserEntity, String> get columnLargeProfilePictureUrl =>
      SqlColumn<UserEntity, String>(
        'largeProfilePictureUrl',
        read: (entity) => entity.largeProfilePictureUrl,
        write: (entity, value) =>
            entity.copyWith(largeProfilePictureUrl: value),
      );

  SqlColumn<UserEntity, String> get columnProfilePictureThumbnailUrl =>
      SqlColumn<UserEntity, String>(
        'profilePictureThumbnailUrl',
        read: (entity) => entity.profilePictureThumbnailUrl,
        write: (entity, value) =>
            entity.copyWith(profilePictureThumbnailUrl: value),
      );

  String? get constructedFullName =>
      fullName ??
      ((givenName?.isNotEmpty != true && familyName?.isNotEmpty != true)
          ? null
          : '${givenName ?? ''} ${familyName ?? ''}');

  SqlColumn<UserEntity, String> get columnPhone =>
      SqlColumn<UserEntity, String>(
        'phone',
        read: (entity) => entity.phone,
        write: (entity, value) => entity.copyWith(phone: value),
      );

  SqlColumn<UserEntity, String> get columnEmail =>
      SqlColumn<UserEntity, String>(
        'email',
        read: (entity) => entity.email,
        write: (entity, value) => entity.copyWith(email: value),
      );

  SqlColumn<UserEntity, String> get columnFullName =>
      SqlColumn<UserEntity, String>(
        'fullName',
        read: (entity) => entity.fullName,
        write: (entity, value) => entity.copyWith(fullName: value),
      );

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
        columnFullName,
        columnEmail,
        columnPhone,
        columnAccessToken,
        columnProfilePictureThumbnailUrl,
        columnLargeProfilePictureUrl,
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
        phone,
        accessToken,
        profilePictureThumbnailUrl,
        largeProfilePictureUrl,
      ]).toList();

  @override
  String get tableName => 'user';

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
    this.fullName,
    this.email,
    this.phone,
    this.xmppPassword,
    this.profilePictureThumbnailUrl,
    this.largeProfilePictureUrl,
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
    String? fullName,
    String? email,
    String? phone,
    String? xmppPassword,
    bool? profileDownloaded,
    String? fcmToken,
    String? accessToken,
    String? profilePictureThumbnailUrl,
    String? largeProfilePictureUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      givenName: givenName ?? this.givenName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      profilePictureThumbnailUrl:
          profilePictureThumbnailUrl ?? this.profilePictureThumbnailUrl,
      largeProfilePictureUrl:
          largeProfilePictureUrl ?? this.largeProfilePictureUrl,
      phone: phone ?? this.phone,
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
