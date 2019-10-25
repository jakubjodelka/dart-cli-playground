import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_cli_playground/data/weather.dart';
import 'package:dart_cli_playground/utils/logger.dart';
import 'package:dart_cli_playground/utils/weather_api.dart' as weatherApi;
import 'package:http/http.dart' as http;
import 'package:io/ansi.dart';
import 'package:mustache/mustache.dart';

const TEMPLATE_FILE_NAME = "{{date}}.txt";
const TEMPLATE_URL =
    "https://gist.githubusercontent.com/jakubjodelka/9b69db1af7e100d06938864ec7174718/raw/f7083e704d36480a66a65f0deb1fb44f58ec2e7f/template.txt";

class ExportCommand extends Command {
  final name = 'export';
  final description = 'Exports weather for today for given location';

  void run() async {
    if (argResults.arguments.isEmpty) {
      throw Exception("City parameter is required");
    }

    final city = argResults.arguments[0];

    final weatherDownloadingProgress = logger
        .progress(green.wrap("Looking for weather for today for city: $city"));
    Weather weather;
    try {
      weather = (await getWeatherForCity(city))[0];
      await Future.delayed(Duration(seconds: 3));
    } catch (error) {
      logger.trace(error.toString());
    }
    weatherDownloadingProgress.finish();

    final fileExportProgress =
        logger.progress(green.wrap("Exporting weather to file"));
    var templateFileContent = (await http.get(TEMPLATE_URL)).body;
    var weatherDate = weather?.date ?? "0";

    var templateFileNameRendered =
        Template(TEMPLATE_FILE_NAME).renderString({"date": weatherDate});
    var templateFileContentRendered =
        Template(templateFileContent).renderString({
      "weather": {
        "temp": weather?.temp,
        "minTemp": weather?.minTemp,
        "maxTemp": weather?.maxTemp
      },
      "weatherDownloaded": weather?.temp != null
    });

    await File(templateFileNameRendered).writeAsString(templateFileContentRendered);
    await Future.delayed(Duration(seconds: 3));
    fileExportProgress.finish(
        message: yellow.wrap("\nWeather for today for $city exported to file"));
  }

  Future<List<Weather>> getWeatherForCity(String city) async {
    return [(await weatherApi.getWeatherForCity(city))[0]];
  }
}
