import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:path/path.dart';

abstract class PrintHelper {
  static void writeLog(String message) {
    final path = join(current, '.git', 'hooks', 'gits-logtime.log');
    final now = DateTime.now();
    final dateLog =
        '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
    if (exists(path)) {
      path.append('$dateLog $message');
    } else {
      path.write('$dateLog $message');
    }
  }

  static void info(String message) {
    writeLog(message);
    print(message);
  }

  static void success(String message) {
    writeLog(message);
    print(green(message));
  }

  static void warning(String message) {
    writeLog(message);
    print(orange(message));
  }

  static void error(String message) {
    writeLog(message);
    printerr(red(message));
  }

  static void generated(String path) {
    final message = 'Generated $path';
    writeLog(message);
    print('${green('Generated')} $path');
  }

  static void errorWithExit(String message, [int exitCode = 1]) {
    error(message);
    exit(exitCode);
  }
}
