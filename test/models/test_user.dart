import 'package:tatlacas_authentication/tatlacas_authentication.dart';

class TestUserRepo extends UserRepo<TestUser> {
  TestUserRepo({required super.storage});

  @override
  Future<TestUser?> getUserFrom(Map<String, dynamic> map) {
    // TODO: implement getUserFrom
    throw UnimplementedError();
  }

  @override
  // TODO: implement type
  TestUser get type => throw UnimplementedError();
}

class TestUser extends UserEntity<TestUser> {
  @override
  TestUser setBaseParams(
      {String? id, DateTime? createdAt, DateTime? updatedAt}) {
    return copyWith(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  const TestUser({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? givenName,
    String? familyName,
    String? refreshToken,
    DateTime? idTokenExpiresOn,
    String? username,
    String? xmppJid,
    String? fullName,
    String? email,
    String? phone,
    String? xmppPassword,
    String? profilePictureThumbnailUrl,
    String? largeProfilePictureUrl,
    bool profileDownloaded = false,
    bool verified = false,
    String? fcmToken,
    String? accessToken,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          givenName: givenName,
          familyName: familyName,
          username: username,
          tokenExpiresOn: idTokenExpiresOn,
          refreshToken: refreshToken,
          xmppJid: xmppJid,
          fullName: fullName,
          email: email,
          phone: phone,
          xmppPassword: xmppPassword,
          avatarUrl: profilePictureThumbnailUrl,
          smallAvatarUrl: largeProfilePictureUrl,
          profileDownloaded: profileDownloaded,
          verified: verified,
          fcmToken: fcmToken,
          accessToken: accessToken,
        );

  @override
  TestUser copyWith({
    String? id,
    DateTime? createdAt,
    String? refreshToken,
    DateTime? tokenExpiresOn,
    DateTime? updatedAt,
    String? givenName,
    String? familyName,
    String? username,
    String? xmppJid,
    String? fullName,
    String? email,
    String? phone,
    String? defaultCurrency,
    String? xmppPassword,
    bool? profileDownloaded,
    bool? verified,
    String? fcmToken,
    String? accessToken,
    String? avatarUrl,
    String? smallAvatarUrl,
  }) {
    return TestUser(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      givenName: givenName ?? this.givenName,
      verified: verified ?? this.verified,
      fullName: fullName ?? this.fullName,
      refreshToken: refreshToken ?? this.refreshToken,
      idTokenExpiresOn: tokenExpiresOn ?? this.tokenExpiresOn,
      email: email ?? this.email,
      profilePictureThumbnailUrl: avatarUrl ?? this.avatarUrl,
      largeProfilePictureUrl: smallAvatarUrl ?? this.smallAvatarUrl,
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
