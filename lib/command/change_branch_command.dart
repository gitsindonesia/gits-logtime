import 'package:args/command_runner.dart';
import 'package:gits_logtime/enum/type_start_time.dart';
import 'package:gits_logtime/helper/config_helper.dart';

class ChangeBranchCommand extends Command {
  @override
  String get name => 'change-branch';

  @override
  String get description => 'Change branch config hooks';

  @override
  void run() async {
    final config = getConfig();
    if (TypeStartTime.fromString(config.type) == TypeStartTime.changeBranch) {
      setConfigStartTime(DateTime.now());
    }
  }
}
