import 'package:dart_cli_playground/commands/weather_command.dart';
import 'package:dart_cli_playground/data/weather.dart';
import 'package:dart_cli_playground/utils/weather_api.dart' as weatherApi;

class TodayCommand extends WeatherCommand {
  final name = 'today';
  final description = 'Prints weather for today for given location';
  final progressMessage = "Looking for weather for today for city:";

  @override
  Future<List<Weather>> getWeatherForCity(String city) async {
    return [(await weatherApi.getWeatherForCity(city))[0]];
  }
}
