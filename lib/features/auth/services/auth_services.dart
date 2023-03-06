import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_github/common/constants/error_handling.dart';
import 'package:flutter_github/features/auth/screens/auth_screen.dart';
import 'package:flutter_github/features/repositories/screens/repositories_screen.dart';
import 'package:flutter_github/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
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
            await prefs.setString("x-auth-token", personalToken).then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, RepositoriesScreen.routeName, (route) => false));
          });
    } catch (e) {
      showMyDialog(context);
    }
  }

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
        final decodeUser = await jsonDecode(tokenRes.body);
        userProvider.setUser(decodeUser, personalToken!);
      }
    } catch (e) {
      showMyDialog(context);
    }
  }

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
