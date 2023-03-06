import 'package:flutter/cupertino.dart';
import 'package:flutter_github/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel(
      id: '',
      login: '',
      accessToken: '',
      avatarUrl: '',
      url: '',
      reposUrl: '',
      followersUrl: '',
      followingUrl: '',
      type: '',
      createdAt: '',
      updatedAt: '');

  UserModel get userModel => _userModel;

  void setUser(Map<String, dynamic> user, String accessToken) {
    Map<String, dynamic> userModel = {
      'id': user['id'].toString(),
      'accessToken': accessToken,
      'login': user['login'],
      'avatarUrl': user['avatar_url'],
      'url': user['url'],
      'reposUrl': user['repos_url'],
      'followersUrl': user['followers_url'],
      'followingUrl': user['following_url'],
      'type': user['type'],
      'createdAt': user['created_at'],
      'updatedAt': user['updated_at']
    };
    _userModel = UserModel.fromMap(userModel);
    notifyListeners();
  }
}
