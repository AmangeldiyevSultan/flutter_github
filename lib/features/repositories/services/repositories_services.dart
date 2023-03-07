import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:flutter_github/models/repositories_model.dart';
import 'package:flutter_github/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RepositoriesServices {
  // fetch all repositories
  Future<RepositoriesModel> fetchRepositories(
      {required BuildContext context}) async {
    final userProvider = context.read<UserProvider>().userModel;
    RepositoriesModel repositoriesModel = RepositoriesModel();
    try {
      http.Response response = await http.get(
          Uri.parse(
            'https://api.github.com/search/repositories?q=user:${userProvider.login}',
          ),
          headers: <String, String>{
            'Authorization': 'token ${userProvider.accessToken}'
          });
      if (response.statusCode == 200) {
        final respositories = jsonDecode(response.body);
        repositoriesModel = RepositoriesModel.fromMap(respositories);
      }
    } catch (e) {
      showMyDialog(context);
    }
    return repositoriesModel;
  }
}
