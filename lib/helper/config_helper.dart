import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:gits_logtime/helper/print_helper.dart';
import 'package:path/path.dart';

import '../models/config.dart';

String createDirHooks() {
  final path = join(current, '.git', 'hooks');
  if (!exists(path)) {
    createDir(path, recursive: true);
  }

  return path;
}

Config getConfig() {
  final path = join(current, '.git', 'hooks', 'gits_logtime.json');
  if (!exists(path)) {
    PrintHelper.errorWithExit('Config file not found');
  }
  final config = File(path).readAsStringSync();
  return Config.fromJson(config);
}

void createConfig(Config config) {
  final path = createDirHooks();
  final file = File(join(path, 'gits_logtime.json'));
  file.writeAsStringSync(config.toJson());
}

void setConfigStartTime(DateTime startTime) {
  final config = getConfig().copyWith(startTime: startTime);
  createConfig(config);
}
