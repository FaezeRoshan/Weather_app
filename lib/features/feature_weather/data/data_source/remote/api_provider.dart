import 'package:dio/dio.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  final apikey = Constants.ApiKey;

  Future<dynamic> CallWeather(CityName) async {
    final response = await _dio.get(
      Constants.BaseUrl,
      queryParameters: {'q': CityName, 'appid': apikey, 'units': 'metric'},
    );

    return response;
  }

  Future<dynamic> Call7Days(ForecastParams params) async {
    final response = await _dio.get(
      Constants.ForeCast,
      queryParameters: {
        
        'latitude': params.lat,
        'longitude': params.lon,
        'daily': 'weather_code,temperature_2m_mean',
        'timezone': 'auto',
        
        
      },
    );
    return response;
  }

   Future<dynamic> sendRequestCitySuggestion(String prefix) async {
    var response = await _dio.get(
        "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
        queryParameters: {'limit': 7, 'offset': 0, 'namePrefix': prefix});

    return response;
  }
}



