import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Error data / error code'),
              Text('information for developers'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Ok',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

enum StateEnum {
  connectionError,
  somethingError,
  emptyList,
  loadError,
}

enum FormEnum {
  signIn,
  issueFrom,
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

List<String> convertBase64(String base64Content, String encoding) {
  List<String> content = [];
  if (encoding == 'base64') {
    List<String> base64List = base64Content.split(RegExp(r'\s+'));
    for (var base64El in base64List) {
      content.add(utf8.decode(base64Url.decode(base64El)));
    }
  }
  return content;
}

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}

String dateFormat(String from, String fromDate, String to) {
  var inputFormat = DateFormat(from);
  var inputDate = inputFormat.parse(fromDate);

  var outputFormat = DateFormat(to);
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
