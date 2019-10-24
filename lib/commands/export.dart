import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_cli_playground/data/weather.dart';
import 'package:dart_cli_playground/utils/logger.dart';
import 'package:dart_cli_playground/utils/weather_api.dart' as weatherApi;
import 'package:http/http.dart' as http;
import 'package:io/ansi.dart';
import 'package:mustache/mustache.dart';

const TEMPLATE_FILE_NAME = "{{date}}.txt";

class ExportCommand extends Command {
  final name = 'export';
  final description = 'Exports weather for today for given location';
  final progressMessageSearchingWeather =
      "Looking for weather for today for city:";

  void run() async {
    if (argResults.arguments.isEmpty)
      throw Exception("City parameter is required");

    final city = argResults.arguments[0];

    final progress =
        logger.progress(green.wrap(progressMessageSearchingWeather + " $city"));

    try {
      var weather = await getWeatherForCity(city);
      var templateFile = await http.get(
          "https://gist.githubusercontent.com/jakubjodelka/9b69db1af7e100d06938864ec7174718/raw/1300002a5545f32a23e035ac5d4b0a36de240d4b/template.txt");
      var templateFileContent = templateFile.body;
      var templateFileNameRendered =
          Template(TEMPLATE_FILE_NAME).renderString({"date": weather[0].date});
      var templateFileContentRendered =
          Template(templateFileContent).renderString({
        "weather": {
          "temp": weather[0].temp,
          "minTemp": weather[0].minTemp,
          "maxTemp": weather[0].maxTemp
        }
      });
      var file = File(templateFileNameRendered);
      await file.writeAsString(templateFileContentRendered);
      progress.finish(message: formatWeather(weather));
      finishProgress(progress);
    } on Exception {
      rethrow;
    }
  }

  Future<List<Weather>> getWeatherForCity(String city) async {
    return [(await weatherApi.getWeatherForCity(city))[0]];
  }
}
