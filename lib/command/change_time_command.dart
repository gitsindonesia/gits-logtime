import 'package:args/command_runner.dart';
import 'package:gits_logtime/helper/config_helper.dart';

class ChangeTimeCommand extends Command {
  @override
  String get name => 'change-time';

  @override
  String get description => 'Change time config hooks';

  @override
  void run() async {
    setConfigStartTime(DateTime.now());
  }
}
