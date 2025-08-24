
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resources/data_state.dart';
import 'package:weather/core/use_case/use_case.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class GetForecastUsecase implements UseCase<DataState<ForecastDaysEntity>, ForecastParams> {
  final WeatherRepository weatherRepository;

  GetForecastUsecase(this.weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>>call(params) {
    return weatherRepository.fetchForecastData(params);
  }
}
