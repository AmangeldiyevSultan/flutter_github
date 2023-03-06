import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReadMeModel {
  String? name;
  String? path;
  String? sha;
  int? size;
  String? url;
  String? type;
  String? content;
  String? encoding;
  int? statusCode;
  ReadMeModel({
    this.name,
    this.path,
    this.sha,
    this.size,
    this.url,
    this.type,
    this.content,
    this.encoding,
    this.statusCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'path': path,
      'sha': sha,
      'size': size,
      'url': url,
      'type': type,
      'content': content,
      'encoding': encoding,
      'status_code': statusCode,
    };
  }

  factory ReadMeModel.fromMap(Map<String, dynamic> map) {
    return ReadMeModel(
      name: map['name'] != null ? map['name'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      sha: map['sha'] != null ? map['sha'] as String : null,
      size: map['size'] != null ? map['size'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      content: map['content'] != null ? map['content']! : null,
      encoding: map['encoding'] != null ? map['encoding'] as String : null,
      statusCode: map['status_code'] != null ? map['status_code'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadMeModel.fromJson(String source) =>
      ReadMeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ReadMeModel copyWith({
    String? name,
    String? path,
    String? sha,
    int? size,
    String? url,
    String? type,
    String? content,
    String? encoding,
    int? statusCode,
  }) {
    return ReadMeModel(
        name: name ?? this.name,
        path: path ?? this.path,
        sha: sha ?? this.sha,
        size: size ?? this.size,
        url: url ?? this.url,
        type: type ?? this.type,
        content: content ?? this.content,
        encoding: encoding ?? this.encoding,
        statusCode: statusCode ?? this.statusCode);
  }
}
