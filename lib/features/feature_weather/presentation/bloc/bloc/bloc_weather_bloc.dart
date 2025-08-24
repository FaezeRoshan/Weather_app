import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/resources/data_state.dart';
import 'package:weather/features/feature_weather/domain/use_cases/get_forecast_usecase.dart';
import 'package:weather/features/feature_weather/domain/use_cases/get_weather_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/cw_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/fw_status.dart';

part 'bloc_weather_event.dart';
part 'bloc_weather_state.dart';

class BlocWeatherBloc extends Bloc<BlocWeatherEvent, BlocWeatherState> {
  final GetWeatherUsecase getWeatherUsecase;
  final GetForecastUsecase getForecastUsecase;
  BlocWeatherBloc(this.getWeatherUsecase, this.getForecastUsecase)
    : super(BlocWeatherState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));
      DataState dataState = await getWeatherUsecase(event.cityName);

      if (dataState is DataSuccess) {
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
      }
    });

    on<LoadFwEvent>((event, emit) async {
      DataState dataState = await getForecastUsecase(event.forecastParams);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newFwStatus: FwCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newFwStatus: FwError(dataState.error!)));
      }
    });
  }
}
