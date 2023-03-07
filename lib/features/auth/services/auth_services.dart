import 'package:flutter/cupertino.dart';
import 'package:flutter_github/common/constants/error_handling.dart';
import 'package:flutter_github/features/auth/screens/auth_screen.dart';
import 'package:flutter_github/features/repositories/screens/repositories_screen.dart';
import 'package:flutter_github/models/user_model.dart';
import 'package:flutter_github/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  // sign in user
  Future<void> signInUser({
    required BuildContext context,
    required String personalToken,
  }) async {
    try {
      http.Response tokenRes = await http.get(
          Uri.parse('https://api.github.com/user'),
          headers: <String, String>{'Authorization': 'Bearer $personalToken'});

      httpErrorHandle(
          response: tokenRes,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            await prefs.setString("x-auth-token", personalToken).then(
                  (value) => getUserData(context: context).then((value) =>
                      Navigator.pushNamedAndRemoveUntil(context,
                          RepositoriesScreen.routeName, (route) => false)),
                );
          });
    } catch (e) {
      showMyDialog(context);
    }
  }

  //get user data
  Future<void> getUserData({
    required BuildContext context,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? personalToken = prefs.getString('x-auth-token');
      if (personalToken == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response tokenRes = await http.get(
          Uri.parse('https://api.github.com/user'),
          headers: <String, String>{'Authorization': 'Bearer $personalToken'});
      if (tokenRes.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(tokenRes.body);
        userModel.accessToken = personalToken!;
        userProvider.setUser(userModel);
      }
    } catch (e) {
      showMyDialog(context);
    }
  }

  // log out
  void logOut({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '').then(
            (value) => Navigator.pushNamedAndRemoveUntil(
                context, AuthScreen.routeName, (route) => false),
          );
    } catch (e) {
      showMyDialog(context);
    }
  }
}
