import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// show snackbar
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

// to show Alert
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

// for trackaring error state
enum StateEnum {
  connectionError,
  somethingError,
  emptyList,
  loadError,
}

// for sign form
enum FormEnum {
  signIn,
  issueFrom,
}

//convert to letters to sentence format
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

// convert from base64 format (for readme)
String convertBase64(String base64Content) {
  return utf8
      .decode(base64.decode(base64Content.replaceAll(RegExp(r'\n'), '')));
}

// convert from hexcolor for github json colors
class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}

// convert to needed date format
String dateFormat(String from, String fromDate, String to) {
  var inputFormat = DateFormat(from);
  var inputDate = inputFormat.parse(fromDate);

  var outputFormat = DateFormat(to);
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
