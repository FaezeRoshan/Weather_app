import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:weather/core/resources/data_state.dart';
import 'package:weather/core/use_case/use_case.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/delete_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/get_all_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/get_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/save_city_usecase.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/delete_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_all_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/save_city_status.dart';



part 'book_mark_event.dart';
part 'book_mark_state.dart';

class BookMarkBloc extends Bloc<BookMarkEvent, BookMarkState> {
  GetCityUsecase getCityUseCase;
  SaveCityUseCase saveCityUseCase;
  GetAllCityUseCase getAllCityUseCase;
  DeleteCityUsecase deleteCityUseCase;
  BookMarkBloc(
    this.getCityUseCase,
    this.saveCityUseCase,
    this.getAllCityUseCase,
    this.deleteCityUseCase,
  ) : super(
        BookMarkState(
          saveCityStatus: SaveCityInitial(),
          getCityStatus: GetCityLoading(),
          getAllCityStatus: GetAllCityLoading(),
          deleteCityStatus: DeleteCityInitial(),
        ),
      ) {
    on<DeleteCityEvent>((event, emit) async {
      emit(state.copyWith(newDeleteCityStatus: DeleteCityLoading()));

      DataState dataState = await deleteCityUseCase(event.name);
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newDeleteCityStatus: DeleteCityCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(newDeleteCityStatus: DeleteCityError(dataState.error)),
        );
      }
    });

      on<GetAllCityEvent>((event, emit) async {

      /// emit Loading state
      emit(state.copyWith(newGetAllCityStatus: GetAllCityLoading()));

      DataState dataState = await getAllCityUseCase(NoParams());

      /// emit Complete state
      if(dataState is DataSuccess){
        emit(state.copyWith(newGetAllCityStatus: GetAllCityCompleted(dataState.data)));
      }

      /// emit Error state
      if(dataState is DataFailed){
        emit(state.copyWith(newGetAllCityStatus: GetAllCityError(dataState.error)));
      }
    });

    /// get city By name event
    on<GetCityByNameEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newgetCityStatus: GetCityLoading()));

      DataState dataState = await getCityUseCase(event.cityName);

      /// emit Complete state
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(newgetCityStatus: GetCityCompleted(dataState.data)),
        );
      }

      /// emit Error state
      if (dataState is DataFailed) {
        emit(state.copyWith(newgetCityStatus: GetCityError(dataState.error)));
      }
    });

    on<SaveCwEvent>((event, emit) async {
      emit(state.copyWith(newsaveCityStatus: SaveCityLoading()));
      DataState dataState = await saveCityUseCase(event.name);
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(newsaveCityStatus: SaveCityCompeleted(dataState.data)),
        );
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newsaveCityStatus: SaveCityError(dataState.error)));
      }
    });

    on<SaveCityInitialEvent>((event, emit) {
      emit(state.copyWith(newsaveCityStatus: SaveCityInitial()));
    });
  }
}
