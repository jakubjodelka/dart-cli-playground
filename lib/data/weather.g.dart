// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

/// This class is the immutable pendant of the [MutableWeather] class.
@immutable
class Weather {
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String date;

  /// Default constructor that creates a new [Weather] with the given attributes.
  const Weather({
    @required this.temp,
    @required this.minTemp,
    @required this.maxTemp,
    @required this.date,
  })  : assert(temp != null),
        assert(minTemp != null),
        assert(maxTemp != null),
        assert(date != null);

  /// Creates a [Weather] from a [MutableWeather].
  Weather.fromMutable(MutableWeather mutable)
      : temp = mutable.temp,
        minTemp = mutable.minTemp,
        maxTemp = mutable.maxTemp,
        date = mutable.date;

  /// Turns this [Weather] into a [MutableWeather].
  MutableWeather toMutable() {
    return MutableWeather()
      ..temp = temp
      ..minTemp = minTemp
      ..maxTemp = maxTemp
      ..date = date;
  }

  /// Checks if this [Weather] is equal to the other one.
  bool operator ==(Object other) {
    return other is Weather &&
        temp == other.temp &&
        minTemp == other.minTemp &&
        maxTemp == other.maxTemp &&
        date == other.date;
  }

  int get hashCode => hashList([
        temp,
        minTemp,
        maxTemp,
        date,
      ]);

  /// Copies this [Weather] with some changed attributes.
  Weather copy(void Function(MutableWeather mutable) changeAttributes) {
    assert(
        changeAttributes != null,
        "You called Weather.copy, but didn't provide a function for changing "
        "the attributes.\n"
        "If you just want an unchanged copy: You don't need one, just use "
        "the original.");
    var mutable = this.toMutable();
    changeAttributes(mutable);
    return Weather.fromMutable(mutable);
  }

  /// Converts this [Weather] into a [String].
  String toString() {
    return 'Weather(\n'
        '  temp: $temp\n'
        '  minTemp: $minTemp\n'
        '  maxTemp: $maxTemp\n'
        '  date: $date\n'
        ')';
  }
}
