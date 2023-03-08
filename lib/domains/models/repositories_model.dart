// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_github/domains/models/repository_model.dart';

class RepositoriesModel {
  int? totalCount;
  bool? incompleteResults;
  List<RepositoryModel>? items;
  RepositoriesModel({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_count': totalCount,
      'incomplete_results': incompleteResults,
      'items': items!.map((x) => x.toMap()).toList(),
    };
  }

  factory RepositoriesModel.fromMap(Map<String, dynamic> map) {
    return RepositoriesModel(
      totalCount: map['total_count'] as int,
      incompleteResults: map['incomplete_results'] as bool,
      items: List<RepositoryModel>.from(
        (map['items']).map<RepositoryModel>(
          (x) => RepositoryModel.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RepositoriesModel.fromJson(String source) =>
      RepositoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
