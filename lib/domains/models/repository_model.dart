import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RepositoryModel {
  int id;
  String name;
  String fullName;
  bool private;
  String? description;
  bool fork;
  String? url;
  String? htmlUrl;
  String? forksUrl;
  String? eventsUrl;
  String? issueEventsUrl;
  String? languagesUrl;
  String? gitCommitsUrl;
  String? createdAt;
  String? updatedAt;
  String? language;
  bool hasIssues;
  String? issueUrl;
  String? visibility;
  int forks;
  int watchers;
  double score;
  String? defaultBranch;
  int openIssues;
  int openIssuesCount;
  Map<String, dynamic>? license;
  RepositoryModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.private,
    this.description,
    required this.fork,
    this.url,
    this.htmlUrl,
    this.forksUrl,
    this.eventsUrl,
    this.issueEventsUrl,
    this.languagesUrl,
    this.gitCommitsUrl,
    this.createdAt,
    this.updatedAt,
    this.language,
    required this.hasIssues,
    this.issueUrl,
    this.visibility,
    required this.forks,
    required this.watchers,
    required this.score,
    this.defaultBranch,
    required this.openIssues,
    required this.openIssuesCount,
    this.license,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'full_name': fullName,
      'private': private,
      'description': description,
      'fork': fork,
      'url': url,
      'html_url': htmlUrl,
      'forks_url': forksUrl,
      'events_url': eventsUrl,
      'issue_events_url': issueEventsUrl,
      'languages_url': languagesUrl,
      'git_commits_url': gitCommitsUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'language': language,
      'has_issues': hasIssues,
      'issue_url': issueUrl,
      'visibility': visibility,
      'forks': forks,
      'watchers': watchers,
      'score': score,
      'default_branch': defaultBranch,
      'open_issues': openIssues,
      'open_issues_count': openIssuesCount,
      'license': license,
    };
  }

  factory RepositoryModel.fromMap(Map<String, dynamic> map) {
    return RepositoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      fullName: map['full_name'] as String,
      private: map['private'] as bool,
      description:
          map['description'] != null ? map['description'] as String : null,
      fork: map['fork'] as bool,
      url: map['url'] != null ? map['url'] as String : null,
      htmlUrl: map['html_url'] != null ? map['html_url'] as String : null,
      forksUrl: map['forks_url'] != null ? map['forks_url'] as String : null,
      eventsUrl: map['events_url'] != null ? map['events_url'] as String : null,
      issueEventsUrl: map['issue_events_url'] != null
          ? map['issue_events_url'] as String
          : null,
      languagesUrl:
          map['languages_url'] != null ? map['languages_url'] as String : null,
      gitCommitsUrl: map['git_commits_url'] != null
          ? map['git_commits_url'] as String
          : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      hasIssues: map['has_issues'] as bool,
      issueUrl: map['issue_url'] != null ? map['issue_url'] as String : null,
      visibility:
          map['visibility'] != null ? map['visibility'] as String : null,
      forks: map['forks'] as int,
      watchers: map['watchers'] as int,
      score: map['score'] as double,
      defaultBranch: map['default_branch'] != null
          ? map['default_branch'] as String
          : null,
      openIssues: map['open_issues'] as int,
      openIssuesCount: map['open_issues_count'] as int,
      license: map['license'] != null
          ? Map<String, dynamic>.from((map['license'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepositoryModel.fromJson(String source) =>
      RepositoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
