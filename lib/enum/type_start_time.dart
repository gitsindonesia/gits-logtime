import 'package:collection/collection.dart';

enum TypeStartTime {
  lastCommit('Take start time from last commit'),
  changeBranch('Take start time from change or create new branch');

  const TypeStartTime(this.description);

  final String description;

  static TypeStartTime fromString(String? name) {
    return TypeStartTime.values.firstWhereOrNull((e) => e.name == name) ??
        TypeStartTime.lastCommit;
  }
}
