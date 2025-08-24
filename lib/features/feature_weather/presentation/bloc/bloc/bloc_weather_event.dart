part of 'bloc_weather_bloc.dart';

@immutable
sealed class BlocWeatherEvent {}

class LoadCwEvent extends BlocWeatherEvent {
  final String cityName;

  LoadCwEvent(this.cityName);
}

class LoadFwEvent extends BlocWeatherEvent {
  final ForecastParams forecastParams;

  LoadFwEvent(this.forecastParams);
}
