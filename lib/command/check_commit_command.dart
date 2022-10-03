import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';
import 'package:gits_logtime/helper/print_helper.dart';
import 'package:path/path.dart';

class CheckCommitCommand extends Command {
  @override
  String get name => 'check-commit';

  @override
  String get description => 'Check commit message format is convesional commit';

  @override
  void run() async {
    final pathFileCommitMessage = join(current, '.git', 'COMMIT_EDITMSG');
    if (!exists(pathFileCommitMessage)) {
      PrintHelper.errorWithExit('File commit message not found');
    }

    final messageCommit = File(pathFileCommitMessage).readAsStringSync();
    final regexConvensionalCommit = RegExp(
        r'^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test){1}(\([\w\-\.]+\))?(!)?: ([\w ])+([\s\S]*)');
    if (regexConvensionalCommit.hasMatch(messageCommit)) {
      PrintHelper.success('Commit message format is convesional commit');
    } else {
      PrintHelper.errorWithExit(
          '''commit message format must be convensional commit

fomrat:
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]''');
    }
  }
}
