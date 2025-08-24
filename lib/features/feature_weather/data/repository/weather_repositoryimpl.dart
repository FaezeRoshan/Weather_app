import 'package:dio/dio.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resources/data_state.dart';
import 'package:weather/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather/features/feature_weather/data/models/current_city_model.dart';
import 'package:weather/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:weather/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class WeatherRepositoryimpl extends WeatherRepository {
  ApiProvider apiProvider;
  WeatherRepositoryimpl(this.apiProvider);
  @override
  Future<DataState<CurrentCityEntity>> fetchWeatherData(String CityName) async {
    try {
      Response response = await apiProvider.CallWeather(CityName);

      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity = CurrentCityModel.fromJson(
          response.data,
        );
        return DataSuccess(currentCityEntity);
      } else {
        return DataFailed("something went wrong. try again...");
      }
    } catch (e) {
      return DataFailed("please check your connection...");
      
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastData(
    ForecastParams params,
  ) async {
    try {
      Response response = await apiProvider.Call7Days(params);
      if (response.statusCode == 200) {
        ForecastDaysEntity forecastDaysEntity = ForecastDaysModel.fromJson(
          response.data,
        );
        return DataSuccess(forecastDaysEntity);
      } else {
        return DataFailed("something went wrong. try again...");
      }
    } catch (e) {
      return DataFailed("please check your connection...");
      
    }
  }

  @override
  Future<List<Data>> fetchSuggestDats(String cityName) async {
    Response response = await apiProvider.sendRequestCitySuggestion(cityName);

    SuggestCityModel suggestCityModel = SuggestCityModel.fromJson(
      response.data,
    );

    return suggestCityModel.data!;
  }
}
