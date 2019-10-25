import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:dart_cli_playground/commands/export.dart';
import 'package:dart_cli_playground/commands/hello.dart';
import 'package:dart_cli_playground/commands/today.dart';
import 'package:dart_cli_playground/commands/week.dart';
import 'package:dart_cli_playground/utils/logger.dart' show logger;
import 'package:io/ansi.dart';

Future<void> weatherRunner(List<String> args) async {
  final runner = CommandRunner('weather', 'Dart weather sample CLI app.');

  runner.argParser.addFlag('verbose',
      abbr: 'v',
      help: 'Print verbose output.',
      negatable: false, callback: (verbose) {
    if (verbose) {
      logger = Logger.verbose();
    } else {
      logger = Logger.standard();
    }
    ;
  });

  runner..addCommand(HelloCommand());
  runner..addCommand(TodayCommand());
  runner..addCommand(WeekCommand());
  runner..addCommand(ExportCommand());

  return await runner.run(args).catchError((exc, st) {
    if (exc is String) {
      logger.stdout(exc);
    } else {
      logger.stderr("⚠️ ${yellow.wrap(exc?.message ?? "Error ocurred")}");
      logger.trace(st.toString());
    }
    exitCode = 1;
  }).whenComplete(() {});
}
