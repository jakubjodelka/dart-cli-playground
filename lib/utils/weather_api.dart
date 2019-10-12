import 'dart:convert' as convert;

import 'package:dart_cli_playground/constants.dart';
import 'package:dart_cli_playground/data/weather.dart';
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';

Future<List<Weather>> getWeatherForCity(String city) async {
  var woeid = await getWoeidForCity(city);
  var weatherApiCallUrl = sprintf(WEATHER_API_URL, [woeid]);
  var response = await http.get(weatherApiCallUrl);
  var jsonResponse = convert.jsonDecode(response.body);

  List<Weather> weather = [];

  (jsonResponse['consolidated_weather'] as List<dynamic>)
    ..forEach((weatherJson) => weather.add(Weather(
        temp: weatherJson['the_temp'],
        minTemp: weatherJson['min_temp'],
        maxTemp: weatherJson['max_temp'],
        date: weatherJson['applicable_date'])));

  return weather;
}

Future<int> getWoeidForCity(String city) async {
  var locationApiCallUrl = sprintf(WOEID_API_URL, [city]);
  var response = await http.get(locationApiCallUrl);
  var jsonResponse = convert.jsonDecode(response.body);
  if((jsonResponse as List).isEmpty) {
    throw Exception("Cannot find city");
  }
  return jsonResponse[0]['woeid'];
}
