import 'package:args/command_runner.dart';
import 'package:dart_cli_playground/utils/logger.dart';

class HelloCommand extends Command {
  final name = 'hello';
  final description = 'Says hello :)';

  void run() async {
    logger.stdout("Hello :)");
  }
}
