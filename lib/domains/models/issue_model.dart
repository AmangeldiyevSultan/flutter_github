import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class IssueModel {
  int? id;
  String? url;
  String? title;
  String? body;
  String? state;
  String? createdAt;
  String? updatedAt;
  IssueModel({
    this.id,
    this.url,
    this.title,
    this.body,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'body': body,
      'state': state,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory IssueModel.fromMap(Map<String, dynamic> map) {
    return IssueModel(
      id: map['id'] != null ? map['id'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IssueModel.fromJson(String source) =>
      IssueModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
