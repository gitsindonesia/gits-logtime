import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:gits_logtime/command/add_command.dart';
import 'package:gits_logtime/command/change_branch_command.dart';
import 'package:gits_logtime/command/check_commit_command.dart';
import 'package:gits_logtime/command/init_command.dart';
import 'package:gits_logtime/helper/print_helper.dart';

void main(List<String> arguments) {
  final runner = CommandRunner(
          'gits-logtime', 'Get it simple command logtime with Gits Logtime')
        //* Command
        ..addCommand(InitCommand())
        ..addCommand(AddCommand())
        ..addCommand(ChangeBranchCommand())
        ..addCommand(CheckCommitCommand())
      //* End Command
      ;

  runner.argParser.addFlag(
    'version',
    abbr: 'v',
    help: 'Reports the version of this tool.',
    negatable: false,
  );

  try {
    final results = runner.argParser.parse(arguments);
    if (results.wasParsed('version')) {
      PrintHelper.info('Gits Logtime 0.3.1');
      exit(0);
    }
  } catch (e) {
    PrintHelper.errorWithExit(e.toString());
  }

  runner.run(arguments).onError((error, stackTrace) {
    PrintHelper.errorWithExit(error.toString());
  });
}
