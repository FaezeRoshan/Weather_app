import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/resources/data_state.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/delete_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/get_all_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/get_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/use_cases/save_city_usecase.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/book_mark_bloc.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/delete_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_all_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/save_city_status.dart';

import 'book_mark_bloc_test.mocks.dart';

@GenerateMocks([
  GetAllCityUseCase,
  DeleteCityUsecase,
  GetCityUsecase,
  SaveCityUseCase,
])
void main() {
  MockGetAllCityUseCase mockGetAllCityUseCase = MockGetAllCityUseCase();
  MockDeleteCityUsecase mockDeleteCityUsecase = MockDeleteCityUsecase();
  MockGetCityUsecase mockGetCityUsecase = MockGetCityUsecase();
  MockSaveCityUseCase mockSaveCityUseCase = MockSaveCityUseCase();
  final cities = <City>[City(name: 'Tehran'), City(name: 'Shiraz')];
  String error = 'error';
  String cityName = 'Tehran';
  City city = City(name:'Tehran' );


  //getAllCityEvent test
  group("getAllCityEvent test ", () {
    when(
      mockGetAllCityUseCase.call(any),
    ).thenAnswer((_) async => Future.value(DataSuccess(cities)));
    blocTest<BookMarkBloc, BookMarkState>(
      "emit Loading and Completed state",
      build:
          () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(GetAllCityEvent());
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityCompleted(cities),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
          ],
    );

    when(
      mockGetAllCityUseCase.call(any),
    ).thenAnswer((_) async => Future.value(DataFailed(error)));
    blocTest<BookMarkBloc, BookMarkState>(
      "emit Loading and Error state",
      build:
          () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(GetAllCityEvent());
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityError(error),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
          ],
    );
  });

  //DeleteCityEvent test
  group("DeleteCityEvent test ", () {
    when(
    mockDeleteCityUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataSuccess(cityName)));
    blocTest<BookMarkBloc, BookMarkState>(
      "emit Loading and Completed state",
      build:
          () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(DeleteCityEvent(cityName));
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityLoading(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityCompleted(cityName),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
          ],
    );

    when(
      mockDeleteCityUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataFailed(error)));
    blocTest<BookMarkBloc, BookMarkState>(
      "emit Loading and Error state",
      build:
          () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(DeleteCityEvent(error));
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityLoading(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityError(error),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
          ],
    );
  });

  //GetCityEvent test
  group("GetCityEvent test", () {
    when(
      mockGetCityUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataSuccess(cities[0])));

    blocTest(
      "emit Loading and Completed state",
      build:
          () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(GetCityByNameEvent(cityName));
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityCompleted(cities[0]),
            ),
          ],
    );

    when(
      mockGetCityUsecase.call(any),
    ).thenAnswer((_) async => Future.value(DataFailed(error)));
    blocTest(
      "emit Loading and Error state",
      build:
          () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(GetCityByNameEvent(cityName));
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityInitial(),
              getCityStatus: GetCityError(error),
            ),
          ],
    );
  });
  

  //SaveCityEvent test
  group("SaveCityEvent test", (){
    when(
    mockSaveCityUseCase.call(any),
    ).thenAnswer((_) async => Future.value(DataSuccess(city)));
   blocTest("emit Loading and Completed state", build: () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(SaveCwEvent(cityName));
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityLoading(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityCompeleted(city),
              getCityStatus: GetCityLoading(),
            ),
          ],);
  
  when(
    mockSaveCityUseCase.call(any),
    ).thenAnswer((_) async => Future.value(DataFailed(error)));
   blocTest("emit Loading and Error state", build: 
   () => BookMarkBloc(
            mockGetCityUsecase,
            mockSaveCityUseCase,
            mockGetAllCityUseCase,
            mockDeleteCityUsecase,
          ),
      act: (bloc) {
        bloc.add(SaveCwEvent(cityName));
      },
      expect:
          () => <BookMarkState>[
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityLoading(),
              getCityStatus: GetCityLoading(),
            ),
            BookMarkState(
              getAllCityStatus: GetAllCityLoading(),
              deleteCityStatus: DeleteCityInitial(),
              saveCityStatus: SaveCityError(error),
              getCityStatus: GetCityLoading(),
            ),
          ],
   );
  });
}
