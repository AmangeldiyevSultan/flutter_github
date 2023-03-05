import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String login;
  String avatarUrl;
  String url;
  String reposUrl;
  String followersUrl;
  String followingUrl;
  String type;
  String createdAt;
  String updatedAt;
  UserModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.url,
    required this.reposUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'login': login,
      'avatarUrl': avatarUrl,
      'url': url,
      'reposUrl': reposUrl,
      'followersUrl': followersUrl,
      'followingUrl': followingUrl,
      'type': type,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      login: map['login'] as String,
      avatarUrl: map['avatarUrl'] as String,
      url: map['url'] as String,
      reposUrl: map['reposUrl'] as String,
      followersUrl: map['followersUrl'] as String,
      followingUrl: map['followingUrl'] as String,
      type: map['type'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
