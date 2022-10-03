import 'package:args/command_runner.dart';
import 'package:collection/collection.dart';
import 'package:gits_logtime/helper/config_helper.dart';
import 'package:gits_logtime/helper/print_helper.dart';
import 'package:gits_logtime/service/service.dart';

class AddCommand extends Command {
  @override
  String get name => 'add';

  @override
  String get description => 'Add time entry to clockify';

  @override
  void run() async {
    final commitMessage = argResults?.rest.firstOrNull;
    if (commitMessage == null) return;

    final config = getConfig();
    final now = DateTime.now();
    DateTime startTime = config.startTime;
    DateTime endTime = now;

    if (DateTime(now.year, now.month, now.day) !=
        DateTime(startTime.year, startTime.month, startTime.day)) {
      startTime = now.subtract(Duration(minutes: 30));
    }

    final startRegex = RegExp(r'(#start:)(\s+)?(\d{2}):(\d{2})');
    final endRegex = RegExp(r'(#end:)(\s+)?(\d{2}):(\d{2})');

    if (startRegex.hasMatch(commitMessage)) {
      startRegex.allMatches(commitMessage).forEach((match) {
        final data = match
                .group(0)
                ?.replaceAll(RegExp(r'#start:(\s+)?'), '')
                .split(':') ??
            ['0', '0'];
        final hour = int.parse(data.first);
        final minute = int.parse(data.last);
        startTime = DateTime(now.year, now.month, now.day, hour, minute);
      });
    }
    if (endRegex.hasMatch(commitMessage)) {
      endRegex.allMatches(commitMessage).forEach((match) {
        final data =
            match.group(0)?.replaceAll(RegExp(r'#end:(\s+)?'), '').split(':') ??
                ['0', '0'];
        final hour = int.parse(data.first);
        final minute = int.parse(data.last);
        endTime = DateTime(now.year, now.month, now.day, hour, minute);
      });
    }

    final result = await Service.addTimeEntry(
      apiKey: config.apiKey,
      workspaceId: config.workspaceId,
      projectId: config.projectId,
      startTime: startTime,
      endTime: endTime,
      description: commitMessage,
    );

    setConfigStartTime(now);

    if (result) {
      PrintHelper.success('Time entry added');
    } else {
      PrintHelper.error('Failed to add time entry');
    }
  }
}
