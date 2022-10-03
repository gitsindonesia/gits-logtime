import 'dart:io';

import 'package:dcli/dcli.dart';

abstract class PrintHelper {
  static void info(String message) => print(message);
  static void success(String message) => print(green(message));
  static void warning(String message) => print(orange(message));
  static void error(String message) => printerr(red(message));
  static void generated(String path) => print('${green('generated')} $path');

  static void errorWithExit(String message, [int exitCode = 1]) {
    printerr(red(message));
    exit(exitCode);
  }
}
