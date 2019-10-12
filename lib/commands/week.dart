import 'package:dart_cli_playground/commands/weather_command.dart';
import 'package:dart_cli_playground/data/weather.dart';
import 'package:dart_cli_playground/utils/weather_api.dart' as weatherApi;

class WeekCommand extends WeatherCommand {
  final name = 'week';
  final description = 'Prints weather for this week for given location';
  final progressMessage = "Looking for weather for this week for city:";

  @override
  Future<List<Weather>> getWeatherForCity(String city) async {
    return weatherApi.getWeatherForCity(city);
  }
}
