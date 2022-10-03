import 'dart:convert';

class Workspace {
  Workspace({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Workspace.fromMap(Map<String, dynamic> map) {
    return Workspace(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Workspace.fromJson(String source) =>
      Workspace.fromMap(json.decode(source));
}
