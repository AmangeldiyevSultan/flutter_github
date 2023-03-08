import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_github/data/common/utils/utils.dart';
import 'package:flutter_github/domains/models/issue_model.dart';
import 'package:flutter_github/domains/models/readme_model.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class RepositoryServices {
  Future<ReadMeModel> fetchReadMe({
    required BuildContext context,
    required String contentUrl,
  }) async {
    ReadMeModel readMeModel = ReadMeModel();
    try {
      final userProvider = context.read<UserProvider>().userModel;

      http.Response response = await http.get(
          Uri.parse('$contentUrl/contents/README.md'),
          headers: <String, String>{
            'Authorization': 'token ${userProvider.accessToken}'
          });

      if (response.statusCode == 200) {
        final readMe = jsonDecode(response.body);

        readMeModel = ReadMeModel.fromMap(readMe);
      }
      readMeModel.statusCode = response.statusCode;
    } catch (e) {
      showMyDialog(context);
    }
    return readMeModel;
  }

  Future<List<IssueModel>> fetchIssues({
    required BuildContext context,
    required String contentUrl,
  }) async {
    List<IssueModel> issueList = [];
    try {
      final userProvider = context.read<UserProvider>().userModel;
      http.Response response = await http
          .get(Uri.parse('$contentUrl/issues'), headers: <String, String>{
        'Authorization': 'token ${userProvider.accessToken}',
        'X-GitHub-Api-Version': '2022-11-28',
      });
      if (response.statusCode == 200) {
        final issues = jsonDecode(response.body);
        for (var issue in issues) {
          issueList.add(IssueModel.fromMap(issue));
        }
      }
    } catch (e) {
      showMyDialog(context);
    }
    return issueList;
  }

  Future<void> createIssue({
    required BuildContext context,
    required String contentUrl,
    required String title,
    required String description,
  }) async {
    try {
      final userProvider = context.read<UserProvider>().userModel;

      Map<String, dynamic> body = {
        'title': title,
        'body': description,
      };

      String jsonBody = json.encode(body);

      await http.post(
          Uri.parse(
            '$contentUrl/issues',
          ),
          body: jsonBody,
          headers: <String, String>{
            'Authorization': 'token ${userProvider.accessToken}',
            'Accept': 'application/vnd.github+json',
            'X-GitHub-Api-Version': '2022-11-28',
          }).then((response) {
        if (response.statusCode != 201) {
          showMyDialog(context);
        }
        if (response.statusCode == 201) {
          Navigator.pop(context);
        }
      });
    } catch (e) {
      showMyDialog(context);
    }
  }
}
