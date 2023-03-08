import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LicenseModel {
  String key;
  String? name;
  String spdxId;
  String url;
  int nodeId;
  LicenseModel({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
    required this.nodeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'name': name,
      'spdx_id': spdxId,
      'url': url,
      'node_id': nodeId,
    };
  }

  factory LicenseModel.fromMap(Map<String, dynamic> map) {
    return LicenseModel(
      key: map['key'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      spdxId: map['spdx_id'] as String,
      url: map['url'] as String,
      nodeId: map['node_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseModel.fromJson(String source) =>
      LicenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
