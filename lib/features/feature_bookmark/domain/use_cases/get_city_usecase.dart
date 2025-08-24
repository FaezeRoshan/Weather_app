import 'package:weather/core/resources/data_state.dart';
import 'package:weather/core/use_case/use_case.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class GetCityUsecase implements UseCase<DataState<City?>, String> {
  CityRepository cityRepository;

  GetCityUsecase(this.cityRepository);
  @override
  Future<DataState<City?>> call(String param) {
   return cityRepository.findCityByName(param);
  }
}
