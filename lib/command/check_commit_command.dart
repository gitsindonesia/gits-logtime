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

    final startRegex = RegExp(r'(#start:)(\s+)?(\d{2}):(\d{2})');
    final endRegex = RegExp(r'(#end:)(\s+)?(\d{2}):(\d{2})');

    if (RegExp(r'#start:(\s+)?').hasMatch(messageCommit)) {
      if (!startRegex.hasMatch(messageCommit)) {
        PrintHelper.errorWithExit('Start time format must be "#start: 00:00"');
      }
    }
    if (RegExp(r'#end:(\s+)?').hasMatch(messageCommit)) {
      if (!endRegex.hasMatch(messageCommit)) {
        PrintHelper.errorWithExit('End time format must be "#end: 00:00"');
      }
    }
  }
}
