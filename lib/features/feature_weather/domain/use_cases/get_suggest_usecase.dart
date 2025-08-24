import 'package:weather/core/use_case/use_case.dart';
import 'package:weather/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class GetSuggestUsecase implements UseCase<List<Data>, String> {
  final WeatherRepository weatherRepository;

  GetSuggestUsecase(this.weatherRepository);
  @override
  Future<List<Data>> call(String param) {
    return weatherRepository.fetchSuggestDats(param);
  }
}
