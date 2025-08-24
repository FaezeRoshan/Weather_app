import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';


class ForecastDaysModel extends ForecastDaysEntity {
 ForecastDaysModel({
    double? latitude,
    double? longitude,
    double? generationtimeMs,
    int? utcOffsetSeconds,
    String? timezone,
    String? timezoneAbbreviation,
    double? elevation,
    DailyUnits? dailyUnits,
    Daily? daily,
  }) : super(latitude: latitude, longitude: longitude, generationtimeMs: generationtimeMs, utcOffsetSeconds: utcOffsetSeconds, timezone: timezone, timezoneAbbreviation: timezoneAbbreviation,
   elevation: elevation, dailyUnits: dailyUnits, daily: daily);

  factory ForecastDaysModel.fromJson(Map<String, dynamic> json) =>
      ForecastDaysModel(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        generationtimeMs: json["generationtime_ms"].toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        dailyUnits: DailyUnits.fromJson(json["daily_units"]),
        daily: Daily.fromJson(json["daily"]),
      );

 
}

class Daily {
  List<DateTime> time;
  List<int> weatherCode;
  List<double> temperature2MMean;

  Daily({required this.time, required this.weatherCode, required this.temperature2MMean});

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
    weatherCode: List<int>.from(json["weather_code"].map((x) => x)),
    temperature2MMean: List<double>.from(
      json["temperature_2m_mean"].map((x) => x.toDouble()),
    ),
  );

}

class DailyUnits {
  String time;
  String weatherCode;
  String temperature2MMean;

  DailyUnits({required this.time, required this.weatherCode, required this.temperature2MMean});

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
    time: json["time"],
    weatherCode: json["weather_code"],
    temperature2MMean: json["temperature_2m_mean"],
  );

 
}
