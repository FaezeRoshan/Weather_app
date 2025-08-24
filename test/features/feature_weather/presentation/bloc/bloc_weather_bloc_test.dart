import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resources/data_state.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather/features/feature_weather/domain/use_cases/get_forecast_usecase.dart';
import 'package:weather/features/feature_weather/domain/use_cases/get_weather_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/bloc_weather_bloc.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/cw_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/fw_status.dart';
import 'bloc_weather_bloc_test.mocks.dart';

@GenerateMocks([GetWeatherUsecase, GetForecastUsecase])
void main() {
  MockGetWeatherUsecase mockGetWeatherUsecase = MockGetWeatherUsecase();
  MockGetForecastUsecase mockGetForecastUsecase = MockGetForecastUsecase();
  String cityName = 'Tehran';
  String error = 'error';
  ForecastParams forecastParams = ForecastParams(35.6892, 51.3890);
  group("cw Event test", () {
    when(
      mockGetWeatherUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataSuccess(CurrentCityEntity())));
    blocTest<BlocWeatherBloc, BlocWeatherState>(
      "emit Loading and Completed state",
      build:
          () => BlocWeatherBloc(mockGetWeatherUsecase, mockGetForecastUsecase),
      act: (bloc) {
        bloc.add(LoadCwEvent(cityName));
      },
      expect:
          () => <BlocWeatherState>[
            BlocWeatherState(cwStatus: CwLoading(), fwStatus: FwLoading()),
            BlocWeatherState(
              cwStatus: CwCompleted(CurrentCityEntity()),
              fwStatus: FwLoading(),
            ),
          ],
    );
  });

  test('emit Loading and Error state', () {
    when(
      mockGetWeatherUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataFailed(error)));
    final bloc = BlocWeatherBloc(mockGetWeatherUsecase, mockGetForecastUsecase);
    bloc.add(LoadCwEvent(cityName));

    expectLater(
      bloc.stream,
      emitsInOrder([
        BlocWeatherState(cwStatus: CwLoading(), fwStatus: FwLoading()),
        BlocWeatherState(cwStatus: CwError(error), fwStatus: FwLoading()),
      ]),
    );
  });

  group("fw Event test", () {
    when(
      mockGetForecastUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataSuccess(ForecastDaysEntity())));
    blocTest<BlocWeatherBloc, BlocWeatherState>(
      "emit Loading and Completed state",
      build:
          () => BlocWeatherBloc(mockGetWeatherUsecase, mockGetForecastUsecase),
      act: (bloc) => bloc.add(LoadFwEvent(forecastParams)),
      expect: () => <BlocWeatherState>[
        BlocWeatherState(fwStatus:  FwCompleted(ForecastDaysEntity()),cwStatus:  CwLoading()),
      ],
    );

     when(
      mockGetForecastUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataFailed(error)));
   blocTest("emit Loading and Error state", build:() => BlocWeatherBloc(mockGetWeatherUsecase, mockGetForecastUsecase), 
   act: (bloc) => bloc.add(LoadFwEvent(forecastParams)),
   expect: () => <BlocWeatherState>[
     
        BlocWeatherState(cwStatus: CwLoading(), fwStatus: FwError(error)),
      ],
   );
  
  });
}
