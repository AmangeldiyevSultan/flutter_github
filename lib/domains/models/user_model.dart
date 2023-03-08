import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? accessToken;
  String? login;
  String? avatarUrl;
  String? url;
  String? reposUrl;
  String? followersUrl;
  String? followingUrl;
  String? type;
  String? createdAt;
  String? updatedAt;
  UserModel({
    this.id,
    this.accessToken,
    this.login,
    this.avatarUrl,
    this.url,
    this.reposUrl,
    this.followersUrl,
    this.followingUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'access_token': accessToken,
      'login': login,
      'avatar_url': avatarUrl,
      'url': url,
      'repos_url': reposUrl,
      'followers_url': followersUrl,
      'following_url': followingUrl,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      accessToken:
          map['access_token'] != null ? map['access_token'] as String : null,
      login: map['login'] != null ? map['login'] as String : null,
      avatarUrl: map['avatar_url'] != null ? map['avatar_url'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      reposUrl: map['repos_url'] != null ? map['repos_url'] as String : null,
      followersUrl:
          map['followers_url'] != null ? map['followers_url'] as String : null,
      followingUrl:
          map['following_url'] != null ? map['following_url'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
