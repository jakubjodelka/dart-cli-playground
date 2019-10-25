import 'package:args/command_runner.dart';
import 'package:dart_cli_playground/data/weather.dart';
import 'package:dart_cli_playground/utils/logger.dart';
import 'package:io/ansi.dart';

abstract class WeatherCommand extends Command {
  String progressMessage;

  void run() async {
    if (argResults.arguments.isEmpty) {
      throw Exception("City parameter is required");
    }

    final city = argResults.arguments[0];
    final progress = logger.progress(green.wrap(progressMessage + " $city"));
    var weather = await getWeatherForCity(city);
    progress.finish(message: "\n ${formatWeather(weather)}");
  }

  Future<List<Weather>> getWeatherForCity(String city);
}
