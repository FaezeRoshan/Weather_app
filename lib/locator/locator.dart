import 'package:get_it/get_it.dart';
import 'package:weather/features/feature_bookmark/data/data_source/local/database.dart';
import 'package:weather/features/feature_bookmark/data/repository/city_repositoryimpl.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/delete_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/get_all_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/get_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/save_city_usecase.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/book_mark_bloc.dart';
import 'package:weather/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather/features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:weather/features/feature_weather/domain/use_cases/get_forecast_usecase.dart';
import 'package:weather/features/feature_weather/domain/use_cases/get_weather_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/bloc_weather_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  final database =await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);
  
  locator.registerSingleton<WeatherRepository>(
    WeatherRepositoryimpl(locator()),
  );
  locator.registerSingleton<CityRepository>(CityRepositoryImpl(database.cityDao));

  locator.registerSingleton<GetWeatherUsecase>(GetWeatherUsecase(locator()));
  locator.registerSingleton<GetForecastUsecase>(GetForecastUsecase(locator()));
   locator.registerSingleton<GetCityUsecase>(GetCityUsecase(locator()));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUsecase>(DeleteCityUsecase(locator()));
  locator.registerSingleton<BlocWeatherBloc>(
    BlocWeatherBloc(locator(), locator()),
  );
   locator.registerSingleton<BookMarkBloc>(BookMarkBloc(locator(),locator(),locator(),locator()));
}
