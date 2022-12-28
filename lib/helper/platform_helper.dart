import 'dart:io';

abstract class PlatformHelper {
  static get commandGitsLogtime =>
      Platform.isWindows ? 'gits-logtime.exe' : 'gits-logtime';
}
