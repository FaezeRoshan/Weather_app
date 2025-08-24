import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_weather/data/models/forecast_days_model.dart';

class ForecastDaysEntity extends Equatable {
  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final DailyUnits? dailyUnits;
  final Daily? daily;

  const ForecastDaysEntity({
     this.latitude,
     this.longitude,
     this.generationtimeMs,
     this.utcOffsetSeconds,
     this.timezone,
     this.timezoneAbbreviation,
     this.elevation,
     this.dailyUnits,
     this.daily,
  });
  @override
  
  List<Object?> get props => [
    
    latitude,
    longitude,
    generationtimeMs,
    utcOffsetSeconds,
    timezone,
    timezoneAbbreviation,
    elevation,
    dailyUnits,
    daily,
  ];

  @override
 
  bool? get stringify => true;
}
