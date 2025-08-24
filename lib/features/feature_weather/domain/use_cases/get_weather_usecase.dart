import 'package:weather/core/resources/data_state.dart';
import 'package:weather/core/use_case/use_case.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class GetWeatherUsecase implements UseCase<DataState<CurrentCityEntity>, String> {
  final WeatherRepository weatherRepository;

  GetWeatherUsecase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>>call(param) {
   return weatherRepository.fetchWeatherData(param);
    
  }
}
