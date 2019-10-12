import 'package:data_classes/data_classes.dart';

part 'weather.g.dart';

@GenerateDataClassFor()
class MutableWeather {
  double temp;
  double minTemp;
  double maxTemp;
  String date;
}
