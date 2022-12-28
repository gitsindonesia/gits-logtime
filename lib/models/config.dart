import 'dart:convert';

class Config {
  Config({
    required this.apiKey,
    required this.userId,
    required this.workspaceId,
    required this.projectId,
    required this.startTime,
    required this.type,
  });

  final String apiKey;
  final String userId;
  final String workspaceId;
  final String projectId;
  final DateTime startTime;
  final String type;

  Config copyWith({
    String? apiKey,
    String? userId,
    String? workspaceId,
    String? projectId,
    DateTime? startTime,
    String? type,
  }) {
    return Config(
      apiKey: apiKey ?? this.apiKey,
      userId: userId ?? this.userId,
      workspaceId: workspaceId ?? this.workspaceId,
      projectId: projectId ?? this.projectId,
      startTime: startTime ?? this.startTime,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'api_key': apiKey,
      'user_id': userId,
      'workspace_id': workspaceId,
      'project_id': projectId,
      'start_time': startTime.toIso8601String(),
      'type': type,
    };
  }

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      apiKey: map['api_key'] ?? '',
      userId: map['user_id'] ?? '',
      workspaceId: map['workspace_id'] ?? '',
      projectId: map['project_id'] ?? '',
      startTime: DateTime.tryParse(map['start_time'] ?? '') ??
          DateTime.now().subtract(Duration(minutes: 30)),
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Config.fromJson(String source) => Config.fromMap(json.decode(source));
}
