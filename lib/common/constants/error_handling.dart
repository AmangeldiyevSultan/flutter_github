import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    default:
      showMyDialog(context);
  }
}
