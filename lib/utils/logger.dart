import 'package:cli_util/cli_logging.dart';
import 'package:dart_cli_playground/data/weather.dart';
import 'package:io/ansi.dart';

import 'table.dart';

Logger logger = Logger.standard();

String formatWeather(List<Weather> entries) {
  var table = Table();

  table.declareColumn("Day", color: green.escape);
  table.declareColumn("Temperature", color: lightGray.escape);
  table.declareColumn("Temp min", color: lightBlue.escape);
  table.declareColumn("Temp max", color: lightRed.escape);
  table.addHeader();
  table.addEmptyRow();
  entries.forEach((entry) {
    table.addEntry(entry.date);
    table.addEntry(entry.temp.roundToDouble());
    table.addEntry(entry.minTemp.roundToDouble());
    table.addEntry(entry.maxTemp.roundToDouble());
  });

  return table.toString();
}